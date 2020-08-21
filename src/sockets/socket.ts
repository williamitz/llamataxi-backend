import  { Socket } from 'socket.io';
import { ListUserSockets } from '../classes/listUserSockets.class';
import { IUserSocket, IUserCoords } from '../interfaces/user-socket.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import IResponse from '../interfaces/resp_promise.interface';
import SocketIO from 'socket.io';
import { INotifySocket } from '../interfaces/body_notify_socket.interface';
import h3 from 'h3-js';
import { UserSocket } from '../classes/userSocket.class';
import { IOffer } from '../interfaces/offer.interface';
import { IWatchGeo, IPayloadServiceNew, IPayloadDel } from '../interfaces/payload-service.interface';

let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

export const connectUser = ( client: Socket ) => {

    listUser.onAddUser( client.id );
    console.log('usuario conectado', client.id);
}

export const singUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('sing-user', (payload: IUserSocket, callback: Function) => {
        const ok = listUser.onSingUser( client.id,
                                        payload.pkUser,
                                        payload.userName,
                                        payload.nameComplete,
                                        payload.role,
                                        payload.device,
                                        payload.osID || '',
                                        payload.pkCategory || 0,
                                        payload.codeCategory || '',
                                        payload.occupied || false
                                        );
        if (!ok) {            
            return callback({
                ok: false, 
                error:{ 
                    message: 'No se encontró usuario socket :(' 
                }
            });
        }
        client.join( payload.device, (err: any) => {
            if (err) {
                console.error(`Ocurrio un error al agregar usuario en la sala ${ payload.device }`);
            } 
        });

        client.join( payload.role, (err: any) => {
            if (err) {
                console.error(`Ocurrio un error al agregar usuario en la sala ${ payload.role }`);
            } 
        });
        
        io.to('WEB').emit('user-connect', { pkUser: payload.pkUser });
        console.log('clientes configurados', listUser.onGetUsers());
        onSingSocketDB(payload.pkUser, payload.osID, true).then( (resSql) => {

            return callback({
                ok: true, 
                message: 'Cliente socket configurado con éxito :D',
                data: resSql.data
            });
            
        }).catch( e => {

            console.error('Error al procesar sql', e);
            // callback({
            //     ok: false,
            //     data: e
            // });
        });
    });
};

export const logoutUser = ( client: Socket, io: SocketIO.Server ) => {

    client.on('logout-user', (payload: any, callback: Function) => {

        const userLogout = listUser.onFindUser( client.id );
        const pkUserLogout = userLogout.pkUser;
        const ok = listUser.onLogoutUser( client.id, pkUserLogout );
        if (!ok) {
            return callback({
                ok: false, 
                error:{ 
                    message: 'No se encontró usuario para desconexión :(' 
                }
            });
        }

        client.leave( userLogout.device || '', (err: any) => {
            if (err) {
                console.error('Ocurrio un error al expulsar usuario en la sala');
            } 
        });
        
        io.to('WEB').emit('user-disconnect', { pkUser: pkUserLogout });
        onSingSocketDB(pkUserLogout, '', false).then( (resSql) => {

            callback({
                ok: true, 
                message: 'Cliente socket desconectado con éxito :D',
                data: resSql.data
            });
            
        }).catch( e => {
            callback({
                ok: false, 
                error: e
            });
            console.error('Error al procesar sql', e);
        });
    });
};

export const disconnectUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('disconnect', (payload, callback: Function) => {
        const userDelete = listUser.onDeleteUser( client.id );

        client.leave( userDelete.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al eliminar usuario de la sala');
            }
        });
    });
};

export const serviceDelRun = ( client: Socket, io: SocketIO.Server ) => {

    client.on('cancel-service-run', ( payload: IPayloadDel, callback: Function ) => {
        const userReceptor = listUser.onFindUserForPk( payload.pkUser );
        
        if (userReceptor.pkUser === 0) {
            return callback({
                ok: false,
                error: {
                    message: 'No se encontró receptor'
                }
            });
        }

        io.in( userReceptor.id ).emit('cancel-service-run-receptor', payload);
        callback({
            ok: true,
            message: 'Se notifico a receptor baja de servicio'
        });

    });
    
}

// notificando a conductores de acuerdo a su categoría 
// cuando se registra un nuevo servicio de taxi
export const newService = ( client: Socket, io: SocketIO.Server, radiusPentagon: number, radiusPather: number ) => {

    client.on('new-service', ( payload: IPayloadServiceNew, callback: Function ) => {

        const indexHexService = h3.geoToH3( payload.coords.lat, payload.coords.lng, radiusPentagon );

        // extraemos las coordenadas de los vértices del polígono
        const polygon = h3.h3ToGeoBoundary( indexHexService, false );
        // extraemos las coordenadas del centro del polígono
        const center = h3.h3ToGeo( indexHexService );

        const drivers = listUser.onFindDriversHex( indexHexService );

        // obtener el padre de la ubicación dada en un radio mas grande
        const indexParent = h3.h3ToParent( indexHexService , radiusPather);

        // extraer los indices hijos de un pentágono con radio 6 del indice padre
        const indexChildren: string[] = h3.h3ToChildren( indexParent , radiusPentagon);

        // notificar a los conductores ue se encuentren en los índices hijos

        let payloadEmit = {
            data: payload.data,
            polygon,
            center,
            indexHex: indexHexService,
            totalDrivers: drivers.length
        };
        
        let driverNotify:UserSocket[] = [];

        switch (payload.codeCategory) {
            case 'BASIC':
                
                // notificamos a todos los conductores en los pentagonos hijos
                indexChildren.forEach( indexHexChildren => {
                    io.in( indexHexChildren ).emit( 'new-service', payloadEmit );
                });

                driverNotify = drivers;

                break;
            case 'STANDAR':
                
                indexChildren.forEach( indexHexChildren => {
                    io.in( `${ indexHexChildren }-STANDAR` ).emit( 'new-service', payloadEmit );
                    io.in( `${ indexHexChildren }-PREMIUM` ).emit( 'new-service', payloadEmit );
                });
                
                driverNotify = drivers.filter( driver => driver.category === 'STANDAR' || driver.category === 'PREMIUM' );
                
                break;
            case 'PREMIUM':
                
                // notificamos a todos los conductores en los pentagonos hijos
                indexChildren.forEach( indexHexChildren => {
                    io.in( `${ indexHexChildren }-PREMIUM` ).emit( 'new-service', payloadEmit );
                });
                driverNotify = drivers.filter( driver => driver.category === 'PREMIUM' );

                break;
        
            default:                
                // notificamos a todos los conductores en los pentagonos hijos
                indexChildren.forEach( indexHexChildren => {
                    io.in( indexHexChildren ).emit( 'new-service', payloadEmit );
                });
                driverNotify = drivers;

                break;
            }
            
            let response = {
                ok: true,
                data: driverNotify,
                total: driverNotify.length,
                error: {
                    message: driverNotify.length === 0 ? 'No se encontrarón conductores cercanos' : ''
                }
            };

        callback( response );

    });
}

// escuchamos cuando un conductor cambia de categoría, 
// agregamos a los conductores a una sala por categoría
export const configCategoryUser = ( client: Socket ) => {
    client.on('change-category', ( payload: any, callback: Function ) => {
        const user = listUser.onFindUser( client.id );

        if (user.pkUser === 0) {
            return callback({ok: false, message: 'Usuario no encontrado'});
        }

        user.pkCategory = payload.pkCategory;
        user.category = payload.codeCategory;
        
        // sacar a los conductores de su sala anterior
        if (user.category != '') {
            
            client.leave( user.category, (error: any) => {
                if (error) {
                    return callback({
                        ok: false,
                        error:{ 
                            message: `Error al abandonar sala ${ user.category } :(` 
                        }
                    });
                }
            });
        }
        
        client.join( payload.codeCategory , (error: any) => {
            if (error) {
                return callback({
                    ok: false,
                    error:{ 
                        message: `Error al agregar a sala ${ user.category } :(` 
                    }
                });
            }
        });
        
        onUpdateCategoryUser( user.pkUser, payload.pkCategory ).then( (res) => {

            callback({ok: true,
                message: `Cambio de categoría con éxito :D`
            });

        }).catch( (e) => {
            
            callback({ok: false,
                message: `Error interno en base de datos`,
                error: e
            });

        });
    });
};

export const sendNotify = (client: Socket, io: SocketIO.Server) => {
    client.on('send-notification-web', async(payload: INotifySocket, callback) => {
        
        let resProm = await onAddNotify( client.id, payload );
        if (!resProm.ok) {

            return callback(callback);
        }
        
        if (resProm.socket !== '') {            
            io.in( resProm.socket || '' ).emit('new-notify-web', payload);
        }
        callback(callback);

    });
}

export const currentPosDriver = ( client: Socket, io: SocketIO.Server, radiusPentagon: number ) => {

    client.on('current-position-driver', (payload: IUserCoords, callback: Function ) => {
        const user = listUser.onFindUser( client.id );
        const oldIndex = user.indexHex;
        const oldCategory = user.category;
        const indexHex = user.onUpdateCoords( payload.lat, payload.lng, radiusPentagon );
        const roomIndex = indexHex;
        const roomIndexCategory = `${ roomIndex }-${ user.category }`;
        const oldRoomIndexCategory = `${ oldIndex }-${ oldCategory }`
        // agregar al usuario a la sala con el indice del pentágono en el que se encuentra
        // user.indexHex = indexHex;

        if (oldIndex !== roomIndex) {

            if (oldIndex !== '') {                
                client.leave( oldIndex, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ roomIndex }`);
                    }
                });
            }

            client.join( roomIndex, (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ roomIndex }`);
                }
            });

        }

        
        if (oldRoomIndexCategory !== roomIndexCategory) {

            if (oldCategory !== '') {
                
                client.leave( oldRoomIndexCategory, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ oldRoomIndexCategory }`);
                    }
                });
            }
        
            client.join( roomIndexCategory, (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ roomIndexCategory }`);
                }
            });
            
        }

        //emitiendo coordenadas al panel para el monitoreo
        const payloadPosition = { 
                                    pkUser: user.pkUser,
                                    coords: payload,
                                    occupied: user.occupied 
                                };
        if (user.pkUser !== 0 ) {            
            io.in('WEB').emit('current-position-driver', payloadPosition);
        }

        // emitiendo coords a clientes vecinos
        const arrChildren: string[] = h3.kRing( indexHex , 1);
        arrChildren.forEach( (indexChildren) => {
            const roomClient = `${ indexChildren }-client`;
            io.in( roomClient ).emit( 'current-position-driver', payloadPosition );
        });
        
        onUpdateCoords( user.pkUser, payload.lat, payload.lng, roomIndex ).then( () => {
            
            // notificar a clients cercanos a la ubicación, y al panel web
            callback({
                ok: true,
                message: `Se actualizo coordenadas, pendiente notificar ${ roomIndex } - ${ roomIndexCategory }`,
                indexHex: roomIndex
            });

        }).catch(e => {
            console.error('Error al actualizar coordenadas', e);
            callback({
                ok: false,
                error: e,
                message: `Error al actualizar coordenadas`
            });
        });
    });

};

export const currentPosClient = ( client: Socket, radiusPentagon: number ) => {
    client.on('current-position-client', (payload: IUserCoords, callback: Function ) => {
        const user = listUser.onFindUser( client.id );
        const oldIndexHex = user.indexHex;
        const indexHex = user.onUpdateCoords( payload.lat, payload.lng, radiusPentagon );

        if ( oldIndexHex !== indexHex ) {
            
            if (oldIndexHex !== '') {                
                const oldRoom = `${ oldIndexHex }-client`;
                client.leave( oldRoom, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ oldRoom }`);
                    }
                });
            }
            
            const newRoom = `${ indexHex }-client`;
            client.join( newRoom , (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ newRoom }`);
                }
            });
        }

        callback({
            ok: true,
            indexHex
        });
    });
};

// escuchando cuando un conductor acepta o envía una oferta
export const newOfferDriver = ( client: Socket, io: SocketIO.Server ) => {
    client.on('newOffer-driver', (payload: any, callback: Function) => {
        const userClient = listUser.onFindUserForPk( Number( payload.pkClient ) );

        if (userClient.pkUser !== 0) {
            // enviar data de oferta
            io.in( userClient.id ).emit('newOffer-service', { dataOffer: payload.dataOffer });
            callback({ok: true, message: 'Se emitió a cliente socket'})
        }

        // callback( {ok: false, message: 'Cliente no conectado' } );

    });
};

// escuchamos cuando el cliente hace una contraoferta o acepta e inicia la carrera
export const newOfferClient = ( client: Socket, io: SocketIO.Server ) => {
    client.on('newOffer-client', (payload: any, callback: Function) => {
        /* // payload
            { dataOffer: offer, accepted }
        */
        const dataOffer: IOffer = payload.dataOffer;
        const userDriver = listUser.onFindUserForPk( Number( dataOffer.fkDriver ) );

        if (userDriver.pkUser !== 0) {
            io.in( userDriver.id ).emit('newOffer-service-client', { dataOffer, accepted: payload.accepted } );
            return callback({ok: true, message: 'Sen emitió a conductor socket'})
        }
        
        callback({ok: false, message: 'conductor desconectado'});

    });
};

// escuchamos cuando el conductor esta ocupado o desocupado de un servicio de taxi
export const changeOccupiedDriver = ( client: Socket ) => {
    client.on('occupied-driver', ( payload: any, callback: Function ) => {
        const driverChangeed = listUser.onChangeOccupierd( payload.pkUser, payload.occupied );
        console.log('cambiando estado conductor', listUser.onGetUsers());
        if (!driverChangeed) {
            return callback({
                ok: false,
                message: 'No se encontró conductor'
            });
        }

        onUpdateOccupied( payload.pkUser, payload.occupied ).then( (res) => {

            callback({
                ok: true,
                message: 'Se cambió estado del conductor'
            });

        }).catch( (e) => {
            callback({
                ok: false,
                error: e
            });
        });
        

    });
};

export const currentPositionService = ( client: Socket, io: SocketIO.Server ) => {
    client.on('current-position-driver-service', ( payload: IWatchGeo, callback: Function ) => {
        const clientSocket = listUser.onFindUserForPk( payload.pkClient );

        if (clientSocket.pkUser === 0) {
            return callback({
                ok: false,
                message: 'No se encontró cliente conectado'
            });
        }

        io.in( clientSocket.id ).emit('current-position-driver', payload);
    
        callback({
            ok: true,
            message: 'Cliente notificado'
        });

    });
};

export const statusTravelDriver = ( client: Socket, io: SocketIO.Server ) => {

    client.on('status-travel-driver', (payload: any, callback: Function) => {
        const clientSocket = listUser.onFindUserForPk( payload.pkClient );

        if (clientSocket.pkUser === 0) {
            return callback({
                ok: false,
                message: 'No se encontró cliente conectado'
            });
        }

        io.in( clientSocket.id ).emit('status-travel-driver', payload);

        onUpdateTravelService( payload, clientSocket.pkUser ).then( (resTravel) => {
            
            callback({
                ok: true,
                message: 'Cliente notificado'
            });
            
        }).catch( e => {
            console.log('Error al cambiar fechas llegada servicio', e);
            callback({
                ok: true,
                message: 'Cliente notificado'
            });
        });

    });
};

function onSingSocketDB( pkUser: number, osId = '', status: boolean ): Promise<IResponse> {
    
    return new Promise( (resolve, reject)  => {
        let sql = `CALL as_sp_singSocket(${ pkUser }, '${ osId }', ${ status });`;
    
        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            if (error) {                
                reject( {ok: false, error} );
            }
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            resolve( { ok: true, data: json } );
        });
    });
}

function onAddNotify( id: string, payload: INotifySocket ): Promise<IResponse> {

    return new Promise( (resolve) => {

        let userAT: any = listUser.onGetAdminSort( 'ATTENTION_ROLE' );
        let userIO: any = listUser.onFindUser( id );
        
        if (!userIO) {
            resolve({
                ok: false,
                error: {
                    message: 'No se encontró usuario socket'
                },
            });
        }

        let sqlNoty = '';
        if (!userAT) {
            let sqlUserAt = `CALL as_sp_getUserAttentionOf()`;
            mysqlCnn.onExecuteQuery(sqlUserAt, (err: any, dataOf: any[]) => {
                
                if (err) {
                    resolve({
                        ok: false,
                        error: err,
                    });
                }
                
                let userOfline = dataOf[0];

                sqlNoty = `CALL as_sp_addNotification( ${ userIO.pkUser }, ${userOfline.pkUser}, '${payload.title}', '${payload.subtitle}', '${payload.message}', '${ payload.urlShow }', ${ userIO.pkUser }, '127:0:0:0' );`;

                mysqlCnn.onExecuteQuery(sqlNoty, (error: any, data: any[]) => {
      
                    if (error) {
                        resolve({
                        ok: false,
                        error,
                        });
                    }
                
                    resolve({
                        ok: true,
                        showError: data[0].showError,
                        data: data[0],
                        socket: ''
                    });
                });
            });
        } else {
            
            sqlNoty = `CALL as_sp_addNotification( ${ userIO.pkUser || 0 }, ${userAT.pkUser}, '${payload.title}', '${payload.subtitle}', '${payload.message}', '${ payload.urlShow }', ${ userIO.pkUser }, '127:0:0:0' );`;

            mysqlCnn.onExecuteQuery(sqlNoty, (error: any, data: any[]) => {
      
                if (error) {
                  resolve({
                    ok: false,
                    error,
                  });
                }
                listUser.onUpdateTime( userAT.id );
                resolve({
                  ok: true,
                  showError: data[0].showError,
                  data: data[0],
                  socket: userAT.id || ''
                });
            });
        }
  });
}

function onUpdateCoords( pkUser: number, lat: number, lng: number, indexHex: string ): Promise<IResponse> {
    return new Promise( (resolve, reject) => {        
        
        let sql = `CALL ts_sp_updateUserCoords( ${ pkUser }, '${ indexHex }', ${ lat }, ${ lng } );`;

        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            if (error) {
                reject({ok: false, error});
            }
            
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            resolve({ok: true, data: json[0]});

        });
    });
}

function onUpdateCategoryUser( pkUser: number, pkCategory: number ): Promise<IResponse> {
    return new Promise( (resolve, reject) => {

        let sql = `CALL ts_sp_updateCategoryDriver( ${ pkUser }, ${ pkCategory } );`;

        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            
            if (error) {
                reject({ok: false, error});
            }
            
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            resolve({ok: true, data: json[0]});

        });
        
    });
}

function onUpdateOccupied( pkUser: number, occupied: boolean ): Promise<IResponse> {
    return new Promise( (resolve, reject) => {

        let sql = `CALL ts_sp_updateOccupied( ${ pkUser }, ${ occupied } );`;

        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            
            if (error) {
                return reject({ok: false, error});
            }
            
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            resolve({ok: true, data: json[0]});

        });
        
    });
}

function onUpdateTravelService( payload: any, pkUser: number ): Promise<IResponse> {
    return new Promise( (resolve, reject) => {

        let sql = `CALL ts_sp_updateTravelService( `;
        sql += `${ payload.pkService }, `;
        sql += `${ payload.runDestination }, `;
        sql += `${ payload.finishDestination }, `;
        sql += `${ pkUser }`;
        sql += `);`;

        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            
            if (error) {
                return reject({ok: false, error});
            }
            
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            resolve({ok: true, data: json[0]});

        });
    });
}

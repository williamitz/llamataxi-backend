import  { Socket } from 'socket.io';
import { ListUserSockets } from '../classes/listUserSockets.class';
import { IUserSocket, IUserCoords, IConfigOs } from '../interfaces/user-socket.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import IResponse from '../interfaces/resp_promise.interface';
import SocketIO from 'socket.io';
import { INotifySocket } from '../interfaces/body_notify_socket.interface';
import h3 from 'h3-js';
import { UserSocket } from '../classes/userSocket.class';
import { IOffer } from '../interfaces/offer.interface';
import { IWatchGeo, IPayloadServiceNew, IPayloadDel, IPayloadTravel, IPayloadChat } from '../interfaces/payload-service.interface';
import { IPanic } from '../interfaces/body_panic.interface';
import Cryptr from 'cryptr';
import { ENCRYPT_KEY, TWILIO_ID, TWILIO_TOKEN, TWILIO_PHONE } from '../global/environments.global';
import twilio from 'twilio';
import { IContact } from '../interfaces/contacs.interfaces';
import { IPlayGeo } from '../interfaces/body_playGeo.interface';
import { IMonitor } from '../interfaces/monitor.interface';
const cryptr = new Cryptr(ENCRYPT_KEY);

const clientTwilio = twilio( TWILIO_ID , TWILIO_TOKEN);

let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

export const connectUser = ( client: Socket ) => {

    listUser.onAddUser( client.id );
    console.log('usuario conectado', client.id);
}

export const configOsID = ( client: Socket ) => {
    client.on('config-osID', (payload: IConfigOs, callback: Function) => {
        const ok = listUser.onConfigOs( client.id, payload.osId );
        if (!ok) {            
            return callback({
                ok: false, 
                error:{ 
                    message: 'No se encontró usuario socket :(' 
                }
            });
        }
        // console.log('clientes configurados', listUser.onGetUsers());
        callback({
            ok: true, 
            data:{ 
                message: 'osId configurado con éxito :)' 
            }
        });

    });
};

export const singUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('sing-user', (payload: IUserSocket, callback: Function) => {

        const userIO = listUser.onFindUser( client.id );
        const osID = payload.osID === '' ? userIO.osID : payload.osID;
        const ok = listUser.onSingUser( client.id,
                                        payload.pkUser,
                                        payload.userName,
                                        payload.nameComplete,
                                        payload.role,
                                        payload.device,
                                        osID,
                                        payload.pkCategory || 0,
                                        payload.codeCategory || '',
                                        payload.occupied || false,
                                        payload.playGeo || false
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
        
        io.in( client.id ).emit('sing-success', { ok: true, message: 'Socket configurado 🙂' } );

        console.log('clientes configurados', listUser.onGetUsers());
        onSingSocketDB(payload.pkUser, osID, true).then( (resSql) => {

            callback({
                ok: true, 
                message: 'Cliente socket configurado con éxito :D',
                data: resSql.data
            });
            
        }).catch( error => {

            console.error('Error al procesar sql', error);
            callback({
                ok: false,
                error
            });
        });
    });
};

export const singMonitor = ( client: Socket ) => {
    client.on( 'sing-monitor', (payload: IMonitor, callback: Function) => {
        if ( !payload.pkService || payload.pkService === 0 ) {
            return callback({
                ok: false,
                error: {
                    message: 'Este abduzcan no es válido 🖤💥'
                }
            });
        }

        listUser.onSingMonitor( client.id, payload.pkService );
        console.log('cliente monitor config', listUser.onGetUsers());
        client.join( `MONITOR-${ payload.pkService }`, (err: any) => {
            if (err) {
                return callback({
                    ok: false,
                    error: {
                        message: 'Error al agregar a sala de monitoreo 💥'
                    }
                });
            }

            return callback({
                ok: true,
                error: {
                    message: 'socket monitor configurado con éxito 🙂'
                }
            });
        });
        
    });
};

export const logoutUser = ( client: Socket, io: SocketIO.Server, sizePather: number, sizeChildren: number ) => {

    client.on('logout-user', (payload: any, callback: Function) => {

        const userLogout = listUser.onFindUser( client.id );
        const pkUser = userLogout.pkUser;
        const device = userLogout.device;
        const role = userLogout.role;
        const indexHex = userLogout.indexHex;
        const category = userLogout.category;
        
        const ok = listUser.onLogoutUser( client.id, pkUser );
        if (!ok) {
            return callback({
                ok: false, 
                error:{ 
                    message: 'No se encontró usuario para desconexión :(' 
                }
            });
        }

        client.leave( device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al expulsar usuario en la sala', device );
            } 
        });

        client.leave( role, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al expulsar usuario en la sala', role);
            } 
        });

        if (indexHex !== '') {            
            client.leave( indexHex, (err: any) => {
                if (err) {
                    console.error('Ocurrio un error al expulsar usuario en la sala', indexHex);
                } 
            });
        }


        if ( category !== '' ) {
            client.leave( category, (err: any) => {
                if (err) {
                    console.error('Ocurrio un error al expulsar usuario en la sala', category);
                } 
            });

            client.leave( `${ indexHex }-${ category }`, (err: any) => {
                if (err) {
                    console.error('Ocurrio un error al expulsar usuario en la sala', `${ indexHex }-${ category }`);
                } 
            });
        }

        
        io.to('WEB').emit('user-disconnect', { pkUser });

        if (role === 'DRIVER_ROLE') {
            
            // const indexParent = h3.h3ToParent( indexHex , sizePather);
            
            // extraer los indices hijos del indice padre
            const indexChildren: string[] = h3.kRing( indexHex , 1);

            indexChildren.forEach( (iChildren) => {
                io.in( `${ iChildren }-client` ).emit( 'logout-driver', { pkUser } );
            });

        }

        onSingSocketDB(pkUser, '', false).then( (resSql) => {

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
        console.log('Usuario desconectado', userDelete.id);
        client.leave( userDelete.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al eliminar usuario de la sala', userDelete.device);
            }
        });

        client.leave( userDelete.role, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al eliminar usuario de la sala', userDelete.role);
            }
        });
        
        if (userDelete.pkService !== 0) {
            client.leave( `MONITOR-${ userDelete.pkService }`, (err: any) => {
                if (err) {
                    console.error('Ocurrio un error al eliminar usuario de la sala de monitoreo');
                }
            });
        }

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

export const changePlayGeo = ( client: Socket, io: SocketIO.Server, sizePather: number, sizeChildren: number ) => {
    client.on('change-play-geo', ( payload: IPlayGeo, callback: Function ) => {
        const userIO = listUser.onFindUser( client.id );
        
        if (userIO.pkUser === 0) {
            return callback({
                ok: false,
                error: {
                    message: 'Usuario socket no authenticado'
                }
            });
        }
        
        const ok = listUser.onChangePlayGeo( client.id, payload.value );
        if (!payload.value) {            
            io.in('WEB').emit('driver-off', { pkUser: userIO.pkUser });

            // const indexParent = h3.h3ToParent( userIO.indexHex , sizePather);
            
            // extraer los indices hijos del indice padre
            const indexChildren: string[] = h3.kRing( userIO.indexHex , 1);

            indexChildren.forEach( (iChildren) => {
                io.in( `${ iChildren }-client` ).emit( 'driver-off', { pkUser: userIO.pkUser } );
            });

            // io.in('CLIENT_ROLE').emit('driver-off', { pkUser: userIO.pkUser });
        }
        
        onUpdatePlayGeo( userIO.pkUser, payload.value ).then( (res) => {

            callback( res );

        }).catch(e => {
            
            // console.error('Error al actualizar playGeo');
            callback(e);

        });
        

    });
}

// notificando a conductores de acuerdo a su categoría 
// cuando se registra un nuevo servicio de taxi
export const newService = ( client: Socket, io: SocketIO.Server, radiusPentagon: number, radiusPather: number ) => {

    client.on('new-service', ( payload: IPayloadServiceNew, callback: Function ) => {

        const indexHex = h3.geoToH3( payload.coords.lat, payload.coords.lng, radiusPentagon );

        // extraemos las coordenadas de los vértices del polígono
        const polygon = h3.h3ToGeoBoundary( indexHex, false );
        // extraemos las coordenadas del centro del polígono
        const center = h3.h3ToGeo( indexHex );

        const drivers = listUser.onFindDriversHex( indexHex );

        // extraer los indices hijos de un pentágono con radio 6 del indice padre
        const indexChildren: string[] = h3.kRing( indexHex , 1);

        // notificar a los conductores ue se encuentren en los índices hijos

        let payloadEmit = {
            data: payload.data,
            polygon,
            center,
            indexHex,
            totalDrivers: drivers.length
        };

        let payloadPanel = {
            indexHex,
            polygon,
            center,
            totalDrivers: drivers.length
        };

        io.in( 'WEB' ).emit( 'new-service', payloadPanel );
        const outDrivers: string[] = [];
        
        let driverNotify:UserSocket[] = [];

        switch (payload.codeCategory) {
            case 'BASIC':
                
                // notificamos a todos los conductores en los pentagonos hijos
                indexChildren.forEach( iChildren => {
                    io.in( iChildren ).emit( 'new-service', payloadEmit );
                    
                    const osIds = listUser.onOsDriversHex( iChildren );
                    outDrivers.push( ...osIds );

                });

                driverNotify = drivers;

                break;
            case 'STANDAR':
                
                indexChildren.forEach( iChildren => {
                    io.in( `${ iChildren }-STANDAR` ).emit( 'new-service', payloadEmit );
                    io.in( `${ iChildren }-PREMIUM` ).emit( 'new-service', payloadEmit );
                    
                    const osIdsST = listUser.onOsDriversCatHex( iChildren, 'STANDAR' );
                    const osIdsPR = listUser.onOsDriversCatHex( iChildren, 'PREMIUM' );
                    outDrivers.push( ...osIdsST );
                    outDrivers.push( ...osIdsPR );

                });
                
                driverNotify = drivers.filter( driver => driver.category === 'STANDAR' || driver.category === 'PREMIUM' );
                
                break;
            case 'PREMIUM':
                
                // notificamos a todos los conductores en los pentagonos hijos
                indexChildren.forEach( iChildren => {
                    io.in( `${ iChildren }-PREMIUM` ).emit( 'new-service', payloadEmit );

                    const osIdsPR = listUser.onOsDriversCatHex( iChildren, 'PREMIUM' );
                    outDrivers.push( ...osIdsPR );
                });
                driverNotify = drivers.filter( driver => driver.category === 'PREMIUM' );

                break;
        }
        
        console.log('conductores notificados', driverNotify);
        let response = {
            ok: true,
            data: driverNotify,
            other: outDrivers,
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
        
        const oldCategory = user.category;
        const oldIndexHex = user.indexHex;
        user.pkCategory = payload.pkCategory;
        user.category = payload.codeCategory;
        
        // sacar a los conductores de su sala anterior
        if (oldCategory != '') {
            
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

            if ( oldIndexHex !== '' ) {
    
                client.leave( `${ oldIndexHex }-${ oldCategory }` , (error: any) => {
                    if (error) {
                        return callback({
                            ok: false,
                            error:{ 
                                message: `Error al agregar a sala ${ user.category } :(` 
                            }
                        });
                    }
                });


                
            }
        }

        client.join( `${ oldIndexHex }-${ payload.codeCategory }`  , (error: any) => {
            if (error) {
                return callback({
                    ok: false,
                    error:{ 
                        message: `Error al agregar a sala ${ user.category } :(` 
                    }
                });
            }
        });

        
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
        
        // console.log('Recibiendo soket app driver', payload);

        const user = listUser.onFindUser( client.id );
        const oldIndex = user.indexHex;
        const category = user.category;
        const indexHex = user.onUpdateCoords( payload.lat, payload.lng, radiusPentagon );
        const roomIndexCategory = `${ indexHex }-${ category }`;
        const oldRoomIndexCategory = `${ oldIndex }-${ category }`
        // agregar al usuario a la sala con el indice del pentágono en el que se encuentra
        // user.indexHex = indexHex;

        if (oldIndex !== indexHex) {

            if (oldIndex !== '') {                
                client.leave( oldIndex, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ indexHex }`);
                    }
                });
            }

            client.join( indexHex, (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ indexHex }`);
                }
            });

        }

        
        if (oldRoomIndexCategory !== roomIndexCategory) {

            if (category !== '') {
                
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
                                    occupied: user.occupied ,
                                    nameComplete: user.nameComplete,
                                    codeCategory: user.category
                                };
        if (user.pkUser !== 0 && user.playGeo ) {          
            io.in('WEB').emit('current-position-driver', payloadPosition);

            // emitiendo coords a clientes vecinos
            const arrChildren: string[] = h3.kRing( indexHex , 1);
            arrChildren.forEach( (indexChildren) => {
                const roomClient = `${ indexChildren }-client`;
                const roomCategClient = `${ indexChildren }-${category}-client`;
                io.in( roomClient ).emit( 'current-position-driver', payloadPosition );
                io.in( roomCategClient ).emit( `current-position-driver-${ category }`, payloadPosition );
            });

            // emitiendo coords a clientes esperando taxistas
            io.in( `${ indexHex }-client` ).emit( 'current-position-driver', payloadPosition );
            io.in( `${ roomIndexCategory }-client` ).emit( `current-position-driver-${ category }`, payloadPosition );

            onUpdateCoords( user.pkUser, payload.lat, payload.lng, indexHex ).then( (resSql) => {
                
                // notificar a clients cercanos a la ubicación, y al panel web
                return callback({
                    ok: true,
                    message: `Se actualizo coordenadas, pendiente notificar ${ indexHex } - ${ roomIndexCategory }`,
                    indexHex,
                    data: resSql.data
                });
    
            }).catch(e => {
                console.error('Error al actualizar coordenadas', e);
                return callback({
                    ok: false,
                    error: e,
                    message: `Error al actualizar coordenadas`
                });
            });

        } else {
            callback({
                ok: false,
                indexHex,
                error: {
                    message: `Conductor no activo su ubicación`
                },
                message: `Conductor no activo su ubicación`
            });

        }

    });

};

export const currentPosClient = ( client: Socket, io: SocketIO.Server, radiusPentagon: number ) => {
    client.on('current-position-client', (payload: IUserCoords, callback: Function ) => {

        const user = listUser.onFindUser( client.id );
        const oldIndexHex = user.indexHex;
        const indexHex = user.onUpdateCoords( payload.lat, payload.lng, radiusPentagon );
        const oldRoom = `${ oldIndexHex }-client`;
        const newRoom = `${ indexHex }-client`;
        const oldRoomHexCategory = `${ oldIndexHex }-${ payload.codeCategory }-client`;
        const roomHexCategory = `${ indexHex }-${ payload.codeCategory }-client`;

        if (user.pkUser === 0) {
            return callback({
                ok: false,
                error: {
                    message: 'No se encontró usuario socket'
                }
            });
        }

        const payloadPosition = { 
            pkUser: user.pkUser,
            coords: payload,
            nameComplete: user.nameComplete,
            codeCategory: user.category
        };

        io.in('WEB').emit('current-position-client', payloadPosition);

        if ( oldIndexHex !== indexHex ) {
            
            if (oldIndexHex !== '') {                
                
                client.leave( oldRoom, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ oldRoom }`);
                    }
                });

                client.leave( oldRoomHexCategory, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ user.userName } de la sala ${ oldRoomHexCategory }`);
                    }
                });

            }
            
            
            client.join( newRoom , (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ newRoom }`);
                }
            });

            client.join( roomHexCategory , (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ user.userName } en la sala ${ roomHexCategory }`);
                }
            });
            
        }

        onUpdateCoords( user.pkUser, payload.lat, payload.lng, indexHex ).then( (resSql) => {
                
            // notificar a clients cercanos a la ubicación, y al panel web
            callback({
                ok: true,
                message: `Se actualizo coordenadas cliente :D`,
                indexHex,
                data: resSql.data
            });

        }).catch(e => {
            console.error('Error al actualizar coordenadas cliente :C', e);
            callback({
                ok: false,
                error: e,
                message: `Error al actualizar coordenadas`
            });
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
            return callback({ok: true, message: 'Se emitió a cliente socket'})
        }

        callback( {ok: false, message: 'Cliente no conectado' } );

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

export const currentPositionService = ( client: Socket, io: SocketIO.Server, radiusPentagon: number ) => {
    client.on('current-position-driver-service', ( payload: IWatchGeo, callback: Function ) => {
        const clientSocket = listUser.onFindUserForPk( payload.pkClient );
        // console.log('nuevo emit geo service', payload);
        // console.log('buscando a nemo', clientSocket);
        if (clientSocket.pkUser != 0) {
            // emitiendo coords a cliente del servicio
            io.in( clientSocket.id ).emit('current-position-driver', payload);
        }

        const driverIO = listUser.onFindUser( client.id );
        const oldIndex = driverIO.indexHex;
        const oldCategory = driverIO.category;
        const indexHex = driverIO.onUpdateCoords( payload.lat, payload.lng, radiusPentagon );
        const roomIndex = indexHex;
        const roomIndexCategory = `${ roomIndex }-${ driverIO.category }`;
        const oldRoomIndexCategory = `${ oldIndex }-${ oldCategory }`
        // agregar al conductor a sala con el indice del pentágono en el que se encuentra

        if (oldIndex !== roomIndex) {

            if (oldIndex !== '') {                
                client.leave( oldIndex, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ driverIO.userName } de la sala ${ roomIndex }`);
                    }
                });
            }

            client.join( roomIndex, (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ driverIO.userName } en la sala ${ roomIndex }`);
                }
            });

        }

        if (oldRoomIndexCategory !== roomIndexCategory) {

            if (oldCategory !== '') {
                
                client.leave( oldRoomIndexCategory, (err: any) => {
                    if (err) {
                        console.error(`Error al expulsar a ${ driverIO.userName } de la sala ${ oldRoomIndexCategory }`);
                    }
                });
            }
        
            client.join( roomIndexCategory, (err: any) => {
                if (err) {
                    console.error(`Error al agregar a ${ driverIO.userName } en la sala ${ roomIndexCategory }`);
                }
            });
            
        }

        const payloadPosition = { 
            pkUser: driverIO.pkUser,
            coords: payload,
            lat: payload.lat,
            lng: payload.lng,
            occupied: true,
            nameComplete: driverIO.nameComplete,
            codeCategory: driverIO.category
        };

        const payloadMonitor = {
            lat: payload.lat,
            lng: payload.lng
        };

        io.in('WEB').emit('current-position-driver', payloadPosition);

        if (payload.pkService && payload.pkService !== 0) { 
            console.log('emitiendo a gente que monitorea');               
            io.in(`MONITOR-${ payload.pkService }`).emit('current-position-driver', payloadMonitor);
        }
        

        onUpdateCoords( driverIO.pkUser, payload.lat, payload.lng, roomIndex ).then( (resSql) => {
            
            // notificar a clients cercanos a la ubicación, y al panel web
            callback({
                ok: true,
                message: `Se actualizo coordenadas con éxito`,
                indexHex: roomIndex,
                data: resSql.data
            });

        }).catch(e => {
            callback({
                ok: false,
                error: e,
                message: `Error al actualizar coordenadas **Viernes***`
            });
        });

    });
};

export const statusTravelDriver = ( client: Socket, io: SocketIO.Server ) => {

    client.on('status-travel-driver', (payload: IPayloadTravel, callback: Function) => {
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

// chat cliente-conductor
export const newChatMessage = ( client: Socket, io: SocketIO.Server ) => {
    client.on('new-message-service', (payload: IPayloadChat, callback: Function) => {

        const clientSocket = listUser.onFindUserForPk( payload.pkUser );
        console.log(`usuario encontrado ${ payload.pkUser }`, clientSocket);
        if (clientSocket.pkUser !== 0) {
            io.in( clientSocket.id ).emit( 'new-chat-message', {} );
        }

        callback({
            ok: true,
            message: 'Notificación enviada'
        });
        
    });
};

// escuchar cuando se envía una alerta de pánico
export const travelPanic = ( client: Socket, io: SocketIO.Server ) => {
    client.on('panic_travel', ( payload: IPanic, callback: Function ) => {
        const user = listUser.onFindUser( client.id );
        
        onAddPanic( payload.pkService, payload.fkPerson, payload.fkUser            
            , user.nameComplete, payload.lat, payload.lng, payload.isClient, io ).then( (res: any) => {

            if (res.showError === 0) {
                
                let sql = `CALL ts_sp_getConactsForAlert(`;
                sql += `${ payload.fkPerson }, `;
                sql += `${ payload.pkService }, `;
                sql += `${ payload.isClient } );`;
            
                mysqlCnn.onExecuteQuery(sql, async (errorNotify: any, data: any[]) => {
                    if (errorNotify) {                
                        console.log('Error al listar los datos de contacto');
                    }

                    let dataString = JSON.stringify(data);
                    let jsonContacts: IContact[] = JSON.parse(dataString);

                    await Promise.all( jsonContacts.map( async (contact) => {

                        console.log('enviando mensjae a ', `${ contact.prefixPhone } ${ contact.phone }`);
                        const twlioRes = await clientTwilio.messages
                        .create({
                              from: TWILIO_PHONE, // de
                              to: `${ contact.prefixPhone } ${ contact.phone }`, // para
                              body: `Llamataxi Perú - ${ contact.msg }`
                        });

                        console.log('Mensaje enviado ', twlioRes.sid);
                    }));

                    callback(res);
                });

            } else {
                callback(res);
            }

        }).catch( (e) => {
            console.log('error al grabar alerta', e);
            callback({
                ok: false,
                message: 'Error interno de base de datos'
            });

        });
    });
};

// escuchar cuando el panel envía un mensaje a un usuario

export const sendMsgPanel = ( client: Socket, io: SocketIO.Server ) => {
    client.on('send-msg-web', ( payload: any, callback: Function ) => {
        const userReceptor = listUser.onFindUserForPk( Number( payload.pkReceptor ) );

        if (userReceptor.pkUser === 0) {
            return callback({
                ok: false,
                message: 'Usuario receptor no conectado' + payload.pkReceptor
            });
        }
        console.log('payload new msg', payload);
        io.in( userReceptor.id ).emit('new-msg', payload);

        callback({
            ok: true,
            message: 'Usuario receptor notificado con éxito'
        });
    });
};

// new-response-to-panel
export const responseMsgPanel = ( client: Socket, io: SocketIO.Server ) => {
    client.on('new-response-to-panel', ( payload: any, callback: Function ) => {

        io.in( 'WEB' ).emit('new-response-msg', payload);

        callback({
            ok: true,
            message: 'Usuarios web notifiados con éxito'
        });
    });
};

// new-response-to-app
export const responseMsgApp = ( client: Socket, io: SocketIO.Server ) => {
    client.on('new-response-to-app', ( payload: any, callback: Function ) => {

        const userReceptor = listUser.onFindUserForPk( Number( payload.pkReceptor ) );

        if (userReceptor.pkUser === 0) {
            return callback({
                ok: false,
                message: 'Usuario receptor no conectado' + payload.pkReceptor
            });
        }
        // console.log('payload new msg', payload);
        io.in( userReceptor.id ).emit('new-response-msg', payload);

        callback({
            ok: true,
            message: 'Usuario receptor notificado con éxito'
        });
    });
};

function onUpdatePlayGeo( pkUser: number, value: boolean ) {

    return new Promise( (resolve, reject)  => {
        let sql = `CALL as_sp_updatePlayGeo(`;
        sql += `${ pkUser }, `;
        sql += `${ value } );`;
    
        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {

            if (error) {                
                reject({
                    ok: false,
                    error,
                    message: 'Error al actualizar playGeo ***Viernes***'
                });
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            resolve({ 
                ok: true, 
                data: json[0],
                showError: json[0].showError,
                message: onGetErrorGeo( json[0].showError ) 
            });

        });
    });
    
}

function onAddPanic( pkService: number, fkPerson: number, fkUser: number
                        , msg: string, lat: number
                        , lng: number, isClient: boolean, io: SocketIO.Server ) {

    return new Promise( (resolve, reject)  => {
        let sql = `CALL ts_sp_addAlert(`;
        sql += `${ pkService }, `;
        sql += `${ fkPerson }, `;
        sql += `${ isClient }, `;
        sql += `${ lat }, `;
        sql += `${ lng }, `;
        sql += `${ fkUser }, `;
        sql += `'127.0.0.0' );`;
    
        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {

            if (error) {                
                reject( {ok: false, error} );
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            if (data[0].showError === 0) {

                const url = `/admin/alertService/${ cryptr.encrypt( data[0].pkAlert ) }`;

                let sql = `CALL ts_sp_addAlertNotify(`;
                sql += `'${ isClient ? 'Alerta cliente' : 'Alerta conductor' }', `;
                sql += `'${ msg }', `;
                sql += `'${ url }', `;
                sql += `${ fkUser }, `;
                sql += `'127.0.0.0' );`;
            
                mysqlCnn.onExecuteQuery(sql, (errorNotify: any, data: any[]) => {
                    if (errorNotify) {                
                        reject( {ok: false, error: errorNotify} );
                    }

                    io.in( 'WEB' ).emit('new-alert-service', { url, msg });

                    resolve({ 
                        ok: true, 
                        data: json[0],
                        showError: json[0].showError,
                        message: onGetError( json[0].showError ) 
                    });
                });
                
            } else {
                resolve({ 
                    ok: true, 
                    data: json[0],
                    showError: json[0].showError,
                    message: onGetError( json[0].showError ) 
                });
            }

        });
    });

}

function onGetErrorGeo( showError: number ): string {
    let arrErr = showError === 0 ? ['Se actualizó play geo con éxito'] : ['Error'];

    if (showError & 1) {
        arrErr.push('No se encontró usuario');
    }

    return arrErr.join(', ');
};

function onGetError( showError: number ): string {
    let arrErr = showError === 0 ? ['Se notificó alerta con éxito'] : ['Error'];

    if (showError & 1) {
        arrErr.push('ya ha notificado una alerta en este servicio');
    }

    if (showError & 2) {
        arrErr.push('no se encontró servicio');
    }

    return arrErr.join(', ');
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

                sqlNoty = `CALL as_sp_addNotification( `;
                sqlNoty += `${ userIO.pkUser }, `;
                sqlNoty += `${userOfline.pkUser}, `;
                sqlNoty += `'${payload.title}', `;
                sqlNoty += `'${payload.subtitle}', `;
                sqlNoty += `'${payload.message}', `;
                sqlNoty += `'${ payload.urlShow }', `;
                sqlNoty += `${ userIO.pkUser }, `;
                sqlNoty += `'127:0:0:0' );`;

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
            
            sqlNoty = `CALL as_sp_addNotification( `;
            sqlNoty += `${ userIO.pkUser || 0 }, `;
            sqlNoty += `${userAT.pkUser}, `;
            sqlNoty += `'${payload.title}', `;
            sqlNoty += `'${payload.subtitle}', `;
            sqlNoty += `'${payload.message}', `;
            sqlNoty += `'${ payload.urlShow }', `;
            sqlNoty += `${ userIO.pkUser }, `;
            sqlNoty += `'127:0:0:0' );`;

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

function onUpdateTravelService( payload: IPayloadTravel, pkUser: number ): Promise<IResponse> {
    return new Promise( (resolve, reject) => {

        let sql = `CALL ts_sp_updateTravelService( `;
        sql += `${ payload.pkService }, `;
        sql += `${ payload.runOrigin }, `;
        sql += `${ payload.finishOrigin }, `;
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

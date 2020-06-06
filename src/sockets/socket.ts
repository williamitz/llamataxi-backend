import  { Socket } from 'socket.io';
import { ListUserSockets } from '../classes/listUserSockets.class';
import { IUserSocket } from '../interfaces/user-socket.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import IResponse from '../interfaces/resp_promise.interface';
import SocketIO from 'socket.io';
import { INotifySocket } from '../interfaces/body_notify_socket.interface';

let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

export const connectUser = ( client: Socket ) => {
    listUser.onAddUser( client.id );
    console.log('usuario conectado', client.id);
}

export const singUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('sing-user', (payload: IUserSocket, callback) => {
        const ok = listUser.onSingUser( client.id,
                                        payload.pkUser,
                                        payload.userName,
                                        payload.role,
                                        payload.device,
                                        payload.osID || '' 
                                        );
        if (!ok) {            
            callback({
                ok: false, 
                error:{ 
                    message: 'Ya existe un usuario configurado :(' 
                }
            });
        }
        client.join( payload.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al agregar usuario en la sala');
            } 
        });
        
        io.to('WEB').emit('user-connect', { pkUser: payload.pkUser });
        console.log('clientes configurados', listUser.onGetUsers());
        onSingSocketDB(payload.pkUser, payload.osID, true).then( (resSql) => {

            callback({
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
    client.on('logout-user', (payload: IUserSocket, callback) => {

        const userLogout = listUser.onFindUser( client.id );
        const ok = listUser.onLogoutUser( client.id );
        if (!ok) {            
            callback({
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
        
        io.to('WEB').emit('user-disconnect', { pkUser: payload.pkUser });
        console.log('clientes configurados', listUser.onGetUsers());
        onSingSocketDB(payload.pkUser, payload.osID, false).then( (resSql) => {

            callback({
                ok: true, 
                message: 'Cliente socket desconectado con éxito :D',
                data: resSql.data
            });
            
        }).catch( e => {
            console.error('Error al procesar sql', e);
        });
    });
};

export const sendNotify = (client: Socket, io: SocketIO.Server) => {
    client.on('send-notification-web', async(payload: INotifySocket, callback) => {
        // recibir id del usuario
        // titulo de noti
        // subtitulo noti
        // mensaje
        
        let resProm = await onAddNotify( client.id, payload );
        if (!resProm.ok) {

            return callback(callback);
        }
        
        if (resProm.socket !== '') {            
            io.in( resProm.socket || '' ).emit('new-notify-web', payload);
        }
        callback(callback);
        /**
         *  'pkUser',
			'role',
			'userName',
			'nameComplete' ;
         */
    });
}

export const disconnectUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('disconnect', (payload, callback: any) => {
        const userDelete = listUser.onDeleteUser( client.id );
        client.leave( userDelete.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al eliminar usuario de la sala');
            }
        });
        io.to('WEB').emit('user-disconnect', { pkUser: userDelete.pkUser });
        onSingSocketDB(userDelete.pkUser || 0, userDelete.osID, false).then( (resSql) => {
            
            // callback( {ok:true, data: resSql} );
            console.log('Se desconecto un usuario', resSql);
            
        }).catch( e => {
            // callback({
            //     ok: false,
            //     error: e
            // });
            console.error('Error al procesar sql', e);
        });
    });
};

function onSingSocketDB( pkUser: number, osId = '', status: boolean ): Promise<IResponse> {
    
    return new Promise( (resolve, reject)  => {
        let sql = `CALL as_sp_singSocket(${ pkUser }, '${ osId }', ${ status });`;
    
        mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
            if (error) {                
                reject( error );
            }

            resolve( { ok: true, data: data[0] } );
        });
    });
}

function onAddNotify( id: string, payload: INotifySocket ): Promise<IResponse> {

    return new Promise( (resolve) => {

        let userAT: any = listUser.onGetAdminSort( 'ATTENTION_ROLE' );
        let userIO: any = listUser.onFindUser( id );
        
        console.log('user socket', userIO);
        console.log('user attention', userAT);
        
        if (!userIO) {
            console.log('no encontramos usuario socket');
            resolve({
                ok: false,
                error: {
                    message: 'No se encontró usuario socket'
                },
            });
        }

        let sqlNoty = '';
        if (!userAT) {
            console.log('no hay atencion al cliente');
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
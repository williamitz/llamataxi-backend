import  { Socket } from 'socket.io';
import { ListUserSockets } from '../classes/listUserSockets.class';
import { IUserSocket } from '../interfaces/user-socket.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import IResponse from '../interfaces/resp_promise.interface';
import SocketIO from 'socket.io';


let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

export const connectUser = ( client: Socket ) => {
    listUser.onAddUser( client.id );
    console.log('usuario conectado', client.id);
}

export const singUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('sing-user', (payload: IUserSocket) => {
        const ok = listUser.onSingUser( client.id, payload.pkUser, payload.userName, payload.role, payload.device, payload.osID || '' );
        if (!ok) {            
            return {ok: false, error:{ message: 'Ya existe un usuario configurado :(' } };
        }
        client.join( payload.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al agregar usuario en la sala');
            } 
        });
        
        io.to('WEB').emit('user-connect', { pkUser: payload.pkUser });
        console.log('clientes configurados', listUser.onGetUsers());
        onSingSocketDB(payload.pkUser, payload.osID, true).then( (resSql) => {

            return {
                ok: true, 
                message: 'Cliente socket configurado con éxito :D',
                data: resSql.data
            };
            
        }).catch( e => {
            console.error('Error al procesar sql', e);
        });
    });
};

export const disconnectUser = ( client: Socket, io: SocketIO.Server ) => {
    client.on('disconnect', () => {
        const userDelete = listUser.onDeleteUser( client.id );
        client.leave( userDelete.device, (err: any) => {
            if (err) {
                console.error('Ocurrio un error al eliminar usuario de la sala');
            }
        });
        io.to('WEB').emit('user-disconnect', { pkUser: userDelete.pkUser });
        onSingSocketDB(userDelete.pkUser, userDelete.osID, false).then( (resSql) => {

            
            console.log('Se desconecto un usuario');
            
        }).catch( e => {
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
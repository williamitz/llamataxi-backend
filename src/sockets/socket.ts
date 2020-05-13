import  { Socket } from 'socket.io';
import { ListUserSockets } from '../classes/listUserSockets.class';
import { IUserSocket } from '../interfaces/user-socket.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import IResponse from '../interfaces/resp_promise.interface';

let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

export const connectUser = ( client: Socket ) => {
    listUser.onAddUser( client.id );
    console.log('usuario conectado', client.id);
}

export const singUser = ( client: Socket ) => {
    client.on('sing-user', (payload: IUserSocket) => {
        const ok = listUser.onSingUser( client.id, payload.pkUser, payload.userName, payload.role, payload.device, payload.osID || '' );
        if (!ok) {            
            return {ok: false, error:{ message: 'Ya existe un usuario configurado :(' } };
        }
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

export const disconnectUser = ( client: Socket ) => {
    client.on('disconnect', () => {
        listUser.onDeleteUser( client.id );
        console.log('Se desconecto un usuario');
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
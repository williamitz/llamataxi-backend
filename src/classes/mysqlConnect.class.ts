// import { PORT_DB, HOST_DB, USER_DB, PASSWORD_DB, NAME_DB } from '../config/enviroment';
import mysql from 'mysql';
import { PORT_DB, HOST_DB, USER_DB, PASSWORD_DB, NAME_DB  } from '../global/environments.global';

export default class MysqlClass {

    private connectDB: mysql.Connection;

    private static _instance: MysqlClass;

    constructor() {
        this.connectDB = mysql.createConnection({
            port: PORT_DB,
            host: HOST_DB,
            user: USER_DB,
            password: PASSWORD_DB,
            database: NAME_DB
        });
        this.onConnect();
    }

    public static get instance() {
        return this._instance || ( this._instance = new this() );
    }
    
    private onConnect() {
        this.connectDB.connect( (error: any) => {
            if (error ) {
                return console.error("Error de conexión con base de datos ===> ", error);                
            }
            console.log("Conectado con base de datos: ", NAME_DB);
        });
    }

    static onNewConnection(port = PORT_DB, host = HOST_DB, user = USER_DB, password = PASSWORD_DB, database = NAME_DB) {
        this.instance.connectDB = mysql.createConnection({
            port,
            host,
            user,
            password,
            database
        });

        this.instance.onConnect();
    }

    onExecuteQuery( sql: string, callback: Function ) {

        this.connectDB.query( sql, ( error: any, result: Object[], fields: any ) => {
            if( error ) {
                console.log('Error al procesar query ===> ', sql);
                console.log(error);
                return callback( error , [] );                
            }

            return callback( null,  result[0] );
        })
    }

}
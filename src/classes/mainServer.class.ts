import express from 'express';
import SocketIO from 'socket.io';
import http from 'http';
import path from 'path';
import { PORT } from '../global/environments.global';
import * as mainSocket from '../sockets/socket';
import moment from 'moment' ;
import IJournalDB from '../interfaces/journal_db.interface';
import MysqlClass from './mysqlConnect.class';
// declare var moment: any;

let MysqlCon = MysqlClass.instance;

export default class MainServer {

    
    private static _instance: MainServer;
    app: express.Application;
    port: number;

    io: SocketIO.Server;
    private _httpServer: http.Server;
    private journal: string;
    private journal_db: IJournalDB[];
    private pkJournal: number;

    constructor() {
        this.app = express();
        this.port = PORT;
        
        this._httpServer = http.createServer( this.app );
        this.io = SocketIO( this._httpServer );
        this.listenSockets();
        this.journal = 'NOCTURN';
        this.journal_db = [];
        this.pkJournal = 0;
    }

    private listenSockets(){
        this.io.on('connect', (client) => {
            mainSocket.connectUser( client );
            mainSocket.disconnectUser( client, this.io );
            mainSocket.singUser( client, this.io  );
            mainSocket.sendNotify( client, this.io );
        });
    }

    private loadJournal() {
        
        MysqlCon.onExecuteQuery('CALL ts_sp_getJurnalAll();', (error: any, data: any[]) => {
            if (error) {
                return console.log('Error en base de datos', error);
            }

            this.journal_db = data;
        });
    }

    private listenTimer() {
        // new moment.duration("1", "minutes").timer({ loop: true }, function () {
        //     console.log('Son las ', moment().format('HH:mm:ss'));
        // });
        // moment.duration("1", "minutes").

        setInterval( () => {

            let hour = Number( moment().format('HH') );

            this.journal_db.forEach( journal => {
                if (hour >= journal.hourStart && hour <= journal.hourEnd) {
                    this.pkJournal = journal.pkJournal;
                    console.log('jornada', journal.nameJournal);
                    if (this.journal !== journal.codeJournal) {
                        console.log('notificar con socket');
                        this.io.to('MOVILE').emit('change-journal', journal);
                        this.journal = journal.codeJournal;
                    }
                }
            });

            // if (hour >= 0 && hour <= 5) {
            //     console.log('nocturno');
            //     if (this.journal !== 'NOCTURN') {
            //         console.log('notificar con socket');
            //         this.journal = 'NOCTURN';
            //     }
            // }else if (hour >= 6 && hour <= 18) {
            //     console.log('diurno');
            //     if (this.journal !== 'DIURN') {
            //         console.log('notificar con socket');
            //         this.journal = 'DIURN';
            //     }
            // }else if( hour >= 19 || hour <= 23 ){
            //     console.log('nocturno');
            //     if (this.journal !== 'NOCTURN') {
            //         console.log('notificar con socket');
            //         this.journal = 'NOCTURN';
            //     }
            // }

            console.log('Son las ', moment().format('HH:mm'));
        }, 60000)
    }
    
    public getJournal(): IJournalDB {
        let hour = Number( moment().format('HH') );
        
        let objJournal = {
            pkJournal: 0,
            nameJournal: 'string',
            codeJournal: 'string',
            hourStart: 0,
            hourEnd: 0,
        };
        this.journal_db.forEach( journal => {
            if (hour >= journal.hourStart && hour <= journal.hourEnd) {
                objJournal = journal;
            }
        });
        return objJournal;
    }

    public static get instance () {
        return this._instance || ( this._instance = new this() );
    }

    private loadPublic() {
        let publicPath = path.resolve( __dirname , '../public' );
        this.app.use( express.static( publicPath ) );
    }

    onRun( callback: Function ) {
        this._httpServer.listen( this.port, callback() );
        this.loadPublic();
        this.loadJournal();
        this.listenTimer();
    }


}
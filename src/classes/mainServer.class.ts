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
    public radiusPentagon: number;

    io: SocketIO.Server;
    private _httpServer: http.Server;
    private journal: string;
    private journal_db: IJournalDB[];
    private pkJournal: number;
    private nameJournal: string;

    private percentRate: number;

    constructor() {
        this.app = express();
        this.port = PORT;
        
        this._httpServer = http.createServer( this.app );
        this.io = SocketIO( this._httpServer );
        this.listenSockets();
        this.journal = 'NOCTURN';
        this.journal_db = [];
        this.pkJournal = 0;
        this.nameJournal = '';
        this.percentRate = 0;
        this.radiusPentagon = 7;
    }

    private listenSockets(){
        this.io.on('connect', (client) => {
            mainSocket.connectUser( client );
            mainSocket.disconnectUser( client, this.io );
            mainSocket.singUser( client, this.io  );
            mainSocket.logoutUser( client, this.io );
            mainSocket.sendNotify( client, this.io );
            mainSocket.currentPosition( client, this.io, this.radiusPentagon );
            mainSocket.newService( client, this.io, this.radiusPentagon );
            mainSocket.configCategoryUser( client );
            mainSocket.newOfferDriver( client, this.io );
        });
    }

    private loadJournal() {
        
        MysqlCon.onExecuteQuery('CALL ts_sp_getJurnalAll();', (error: any, data: any[]) => {
            if (error) {
                return console.log('Error en base de datos', error);
            }
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            
            this.journal_db = json;
        });

    }

    private loadPercentRate() {
        MysqlCon.onExecuteQuery('CALL ts_sp_getPercentRate();', (error: any, data: any[]) => {
            if (error) {
                return console.log('Error en base de datos al listar el porcentaje de tarifa', error);
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            // console.log('porcentaje minimo', json);
            this.percentRate = json[0].percentRate || 0;
        });
    }

    private listenTimer() {
        // new moment.duration("1", "minutes").timer({ loop: true }, function () {
        //     console.log('Son las ', moment().format('HH:mm:ss'));
        // });
        // moment.duration("1", "minutes").

        setInterval( () => {

            let hour = Number( moment().format('HH') );
            let minutes = Number( moment().format('mm') );
            
            let hhStartDB = 0;
            let mmStartDB = 0;

            let hhEndDB = 0;
            let mmEndDB = 0;
            this.journal_db.forEach( journal => {

                let arrStart = journal.hourStart.split(':');
                let arrEnd = journal.hourEnd.split(':');
                
                hhStartDB = Number( arrStart[0] ) || 0;
                mmStartDB = Number( arrStart[1] ) || 0;
                
                hhEndDB = Number( arrEnd[0] ) || 0;
                mmEndDB = Number( arrEnd[1] ) || 0;
                        
                if ( ( hour >= hhStartDB && (minutes >= 0 || minutes <=  mmStartDB)) && ( hour <= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {

                    this.pkJournal = journal.pkJournal;
                    this.nameJournal = journal.nameJournal;
                    // console.log('jornada', journal.nameJournal);

                    if (this.journal !== journal.codeJournal) {
                        console.log('notificar con socket');
                        this.io.to('MOVILE').emit('change-journal', journal);
                        this.journal = journal.codeJournal;
                    }
                }
            });

            console.log('Son las ', moment().format('HH:mm') , ` - jornada ${ this.pkJournal } ${ this.nameJournal }`);
        }, 60000)
    }
    
    public getJournal(): IJournalDB {
        
        let objJournal = {
            pkJournal: 0,
            nameJournal: '',
            codeJournal: '',
            hourStart: '',
            hourEnd: '',
        };

        let hour = Number( moment().format('HH') );
        let minutes = Number( moment().format('mm') );
        
        let hhStartDB = 0;
        let mmStartDB = 0;
        
        let hhEndDB = 0;
        let mmEndDB = 0;
        this.journal_db.forEach( journal => {
        
            let arrStart = journal.hourStart.split(':');
            let arrEnd = journal.hourEnd.split(':');
            
            hhStartDB = Number( arrStart[0] ) || 0;
            mmStartDB = Number( arrStart[1] ) || 0;
            
            hhEndDB = Number( arrEnd[0] ) || 0;
            mmEndDB = Number( arrEnd[1] ) || 0;
        
            if ( ( hour >= hhStartDB && (minutes >= 0 || minutes <=  mmStartDB)) && ( hour <= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {

                objJournal = journal;
                return journal;
            }
        });

        return objJournal;
    }

    public getPercentRate(): number {
        return this.percentRate;
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
        this.loadPercentRate();
    }


}
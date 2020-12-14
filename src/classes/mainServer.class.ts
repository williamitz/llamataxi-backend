import express from 'express';
import SocketIO from 'socket.io';
import http from 'http';
import path from 'path';
import { PORT } from '../global/environments.global';
import * as mainSocket from '../sockets/socket';
import moment from 'moment' ;
import IJournalDB from '../interfaces/journal_db.interface';
import MysqlClass from './mysqlConnect.class';
import { IRateJournal } from '../interfaces/rateForJournal.interface';
import { IConfigSystem } from '../interfaces/configSystem.interface';
// declare var moment: any;

let MysqlCon = MysqlClass.instance;

export default class MainServer {

    private static _instance: MainServer;
    app: express.Application;
    port: number;
    public radiusPentagon: number;
    public radiusPather: number;

    io: SocketIO.Server;
    private _httpServer: http.Server;
    private journal: string;
    private journal_db: IJournalDB[];
    private currentJournal: IJournalDB;
    private rateJournal_db: IRateJournal[];
    private pkJournal: number;
    private nameJournal: string;
    public ccSystem: IConfigSystem;

    private percentRate: number;
    private intervalJorunal: NodeJS.Timeout;

    constructor() {
        this.app = express();
        this.port = PORT;
        
        this._httpServer = http.createServer( this.app );
        this.io = SocketIO( this._httpServer );
        this.listenSockets();
        this.journal = 'NOCTURN';
        this.journal_db = [];
        this.rateJournal_db = [];
        this.pkJournal = 0;
        this.nameJournal = '';
        this.percentRate = 0;
        this.radiusPentagon = 6;
        this.radiusPather = 4;
        this.currentJournal = {
            pkJournal: 0,
            codeJournal: 'DIURN',
            hourEnd: '',
            hourStart: '',
            nameJournal: '',
            rates: []
        };
        this.ccSystem = {
            pkConfig: 0,
            percentRate: 0,
            culquiKey: '',
            culquiKeyPublic: ''
        };
        this.intervalJorunal = setInterval(() => {}, 60000);
    }

    private listenSockets(){
        this.io.on('connect', (client) => {
            mainSocket.connectUser( client );
            mainSocket.disconnectUser( client, this.io );
            mainSocket.singUser( client, this.io  );
            mainSocket.singMonitor( client );
            mainSocket.configOsID( client );
            mainSocket.logoutUser( client, this.io, this.radiusPather, this.radiusPentagon );
            mainSocket.sendNotify( client, this.io );
            mainSocket.currentPosDriver( client, this.io, this.radiusPentagon );
            mainSocket.currentPosClient( client, this.io, this.radiusPentagon );
            mainSocket.serviceDelRun( client, this.io );
            mainSocket.newService( client, this.io, this.radiusPentagon, this.radiusPather );
            mainSocket.configCategoryUser( client );
            mainSocket.newOfferDriver( client, this.io );
            mainSocket.newOfferClient( client, this.io );
            mainSocket.changeOccupiedDriver( client );
            mainSocket.currentPositionService( client, this.io, this.radiusPentagon );
            mainSocket.statusTravelDriver( client, this.io );
            mainSocket.travelPanic( client, this.io );
            mainSocket.newChatMessage( client, this.io );
            mainSocket.sendMsgPanel( client, this.io );
            mainSocket.responseMsgPanel( client, this.io );
            mainSocket.responseMsgApp( client, this.io );
            mainSocket.changePlayGeo( client, this.io, this.radiusPather, this.radiusPentagon );
            
        });
    }

    public loadJournal() {
        
        MysqlCon.onExecuteQuery('CALL ts_sp_getJurnalAll();', (error: any, data: any[]) => {
            if (error) {
                return console.log('Error en base de datos', error);
            }
            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            
            this.journal_db = json;
            this.listenJournal();
        });

    }

    public loadRateJournal( journal: IJournalDB ) {

        let sql = `CALL ts_sp_getRateForJournal(${ this.pkJournal });`;
        MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

            if (error) {
                return console.log('Error en base de datos al listar tarifa segun la hora', error);
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            this.rateJournal_db = json;

            journal.rates = json;
            this.currentJournal = journal;
            console.log('notificando con socket', journal);
            this.io.to('MOVILE').emit('change-journal', journal);
            this.io.to('WEB').emit('change-journal', journal);
        
        });

    }

    public reLoadRateJournal( ) {

        let sql = `CALL ts_sp_getRateForJournal(${ this.pkJournal });`;
        MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

            if (error) {
                return console.log('Error en base de datos al listar tarifa segun la hora', error);
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);

            this.currentJournal.rates = json;
            console.log('notificando con socket', this.currentJournal);
            this.io.to('MOVILE').emit('change-journal', this.currentJournal);
            this.io.to('WEB').emit('change-journal', this.currentJournal);
        
        });

    }

    // public loadPercentRate() {
    //     MysqlCon.onExecuteQuery('CALL ts_sp_getPercentRate();', (error: any, data: any[]) => {
    //         if (error) {
    //             return console.log('Error en base de datos al listar el porcentaje de tarifa', error);
    //         }

    //         let dataString = JSON.stringify(data);
    //         let json = JSON.parse(dataString);
    //         this.percentRate = json[0].percentRate || 0;
    //     });
    // }

    public loadConfigSystem() {
        MysqlCon.onExecuteQuery('CALL as_sp_getConfigSystem();', (error: any, data: any[]) => {
            if (error) {
                return console.log('Error en base de datos al listar config system', error);
            }

            let dataString = JSON.stringify(data);
            let json = JSON.parse(dataString);
            this.ccSystem = json[0];
        });
    }

    private listenJournal() {

        console.log('iniciando interval jornada');
        clearInterval( this.intervalJorunal );
        this.intervalJorunal = setInterval( () => {

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


                if ( ( hour >= hhStartDB && (minutes >= 0 || minutes >=  mmStartDB)) ) {
                
                    if ( hhEndDB > 12 ) {
                        if ( ( hour <= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {
                            
                            if (this.pkJournal !== journal.pkJournal) {

                                this.pkJournal = journal.pkJournal;
                                this.nameJournal = journal.nameJournal;
                                this.journal = journal.codeJournal;
                                this.loadRateJournal( journal );
                            }
                        }
                    } else {
    
                        if ( ( hour >= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {
                            
                            if (this.pkJournal !== journal.pkJournal) {

                                this.pkJournal = journal.pkJournal;
                                this.nameJournal = journal.nameJournal;
                                this.journal = journal.codeJournal;
                                this.loadRateJournal( journal );
                            }
                        }
                    }
                    // return journal;
                }
                        
                // if ( ( hour >= hhStartDB && (minutes >= 0 || minutes >=  mmStartDB)) && ( hour <= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {

                    
                //     // console.log('jornada', journal.nameJournal);

                //     if (this.pkJournal !== journal.pkJournal) {

                //         this.pkJournal = journal.pkJournal;
                //         this.nameJournal = journal.nameJournal;
                //         this.journal = journal.codeJournal;
                //         this.loadRateJournal( journal );
                //     }
                // }
            });

            console.log('Son las ', moment().format('HH:mm') , ` - jornada ${ this.pkJournal } ${ this.nameJournal }`);
        }, 60000);
    }
    
    public getJournal(): IJournalDB {
        
        let objJournal = {
            pkJournal: 0,
            nameJournal: '',
            codeJournal: '',
            hourStart: '',
            hourEnd: '',
        };
        // console.log(`hora actual ${ moment().format('HH') }:${ moment().format('mm') }`);
        let hour = Number( moment().format('HH') );// 22
        let minutes = Number( moment().format('mm') );// 23
        
        let hhStartDB = 0;
        let mmStartDB = 0;
        
        let hhEndDB = 0;
        let mmEndDB = 0;
        this.journal_db.forEach( journal => {
            // console.log(`jornada db `, journal);
        
            let arrStart = journal.hourStart.split(':');
            let arrEnd = journal.hourEnd.split(':');
            
            hhStartDB = Number( arrStart[0] ) || 0;
            mmStartDB = Number( arrStart[1] ) || 0;
            
            hhEndDB = Number( arrEnd[0] ) || 0;
            mmEndDB = Number( arrEnd[1] ) || 0;
        
            if ( ( hour >= hhStartDB && (minutes >= 0 || minutes >=  mmStartDB)) ) {
                
                if ( hhEndDB > 12 ) {
                    if ( ( hour <= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {
                        
                        objJournal = journal;
                    }
                } else {

                    if ( ( hour >= hhEndDB && ( minutes >= 0 || minutes <=  mmEndDB)) ) {
                        
                        objJournal = journal;
                    }
                }
                // return journal;
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

    //     setTimeout(() => {
            
    //         this.loadJournal();
    //         // this.listenJournal();
    //         this.loadPercentRate();
    //     }, 5000);
    // }
    }

}
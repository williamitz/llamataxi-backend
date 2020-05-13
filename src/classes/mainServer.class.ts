import express from 'express';
import { PORT } from '../global/environments.global';
import SocketIO from 'socket.io';
import http from 'http';
import * as mainSocket from '../sockets/socket';

export default class MainServer {
    
    private static _instance: MainServer;
    app: express.Application;
    port: number;

    private _io: SocketIO.Server;
    private _httpServer: http.Server;

    constructor() {
        this.app = express();
        this.port = PORT;

        this._httpServer = new http.Server( this.app );
        this._io = SocketIO( this._httpServer );
        this.listenSockets();
    }

    private listenSockets(){
        this._io.on('connect', (client) => {
            mainSocket.connectUser( client );
            mainSocket.disconnectUser( client );
            mainSocket.singUser( client );
        });
    }

    public static get instance () {
        return this._instance || ( this._instance = new this() );
    }

    onRun( callback: Function ) {
        this._httpServer.listen( this.port, callback() );
    }


}
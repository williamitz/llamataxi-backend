import express from 'express';
import SocketIO from 'socket.io';
import http from 'http';
import path from 'path';
import { PORT } from '../global/environments.global';
import * as mainSocket from '../sockets/socket';
export default class MainServer {

    
    private static _instance: MainServer;
    app: express.Application;
    port: number;

    io: SocketIO.Server;
    private _httpServer: http.Server;

    constructor() {
        this.app = express();
        this.port = PORT;
        
        this._httpServer = http.createServer( this.app );
        this.io = SocketIO( this._httpServer );
        this.listenSockets();
    }

    private listenSockets(){
        this.io.on('connect', (client) => {
            mainSocket.connectUser( client );
            mainSocket.disconnectUser( client, this.io );
            mainSocket.singUser( client, this.io  );
            mainSocket.sendNotify( client, this.io );
        });
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
    }


}
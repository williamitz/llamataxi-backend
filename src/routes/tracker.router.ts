import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import MainServer from "../classes/mainServer.class";
import { ListUserSockets } from "../classes/listUserSockets.class";
import h3 from 'h3-js';
import { ITracker } from '../interfaces/body_tracker.interface';

let TrackerRouter = Router();
let mainServer = MainServer.instance;
let listUser = ListUserSockets.instance;
let mysqlCnn = MysqlClass.instance;

TrackerRouter.post('/Tracker/Geo',[verifyToken], (req: any, res: Response) => {
    let body: ITracker = req.body;
    let fkUser = req.userData.pkUser || 0;

    console.log('Recibiendo tracker post', body);

    const user = listUser.onFindUserForPk( fkUser );
    const codeCategory = user.category;
    const indexHex = user.onUpdateCoords( body.lat, body.lng, mainServer.radiusPentagon );

    //emitiendo coordenadas al panel para el monitoreo
    const payloadPosition = {
        pkUser: user.pkUser,
        coords: body,
        lat: body.lat,
        lng: body.lng,
        occupied: user.occupied ,
        nameComplete: user.nameComplete,
        codeCategory
    };
    
    const payloadMonitor = {
        lat: body.lat,
        lng: body.lng
    };

    if (user.pkUser !== 0 && user.playGeo ) {
        mainServer.io.in('WEB').emit('current-position-driver', payloadPosition);
        
        if (body.pkService && body.pkService !== 0) {                
            mainServer.io.in(`MONITOR-${ body.pkService }`).emit('current-position-driver', payloadMonitor);
        }

    }
    
    if (user.pkUser !== 0 && !user.occupied) {
        // emitiendo coords a clientes vecinos
        const arrChildren: string[] = h3.kRing( indexHex , 1);
        arrChildren.forEach( (indexChildren) => {
            const roomClient = `${ indexChildren }-client`;
            mainServer.io.in( roomClient ).emit( 'current-position-driver', payloadPosition );
        });
    }

    if (body.run) {

        const clientSocket = listUser.onFindUserForPk( body.pkClient || 0 );

        if (clientSocket.pkUser !== 0) {
            mainServer.io.in( clientSocket.id ).emit('current-position-driver', body);
        }

    }

    let sql = `CALL ts_sp_updateUserCoords( `;
    sql += `${ fkUser }, `;
    sql += `'${ indexHex }', `;
    sql += `${ body.lat }, `;
    sql += `${ body.lng } );`;

    mysqlCnn.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        res.json({
            ok: true,
            data: data[0]
        });

    });
    
});

export default TrackerRouter;
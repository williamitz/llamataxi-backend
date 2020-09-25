import { Request, Response, Router } from "express";
import { IBodyJournal } from "./../interfaces/body_journal.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
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
    const indexHex = user.onUpdateCoords( body.lat, body.lng, mainServer.radiusPentagon );

    //emitiendo coordenadas al panel para el monitoreo
    const payloadPosition = { 
                                pkUser: user.pkUser,
                                coords: body,
                                occupied: user.occupied ,
                                nameComplete: user.nameComplete,
                                codeCategory: user.category
                            };
    if (user.pkUser !== 0 && user.playGeo ) {   
        mainServer.io.in('WEB').emit('current-position-driver', payloadPosition);
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
            res.status(400).json({
                ok: false,
                data: {
                    message: 'Track recibido con éxito'
                }
            });
        }
        
        res.json({
            ok: true,
            data: data[0]
        });

    });
    
});

export default TrackerRouter;
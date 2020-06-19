import { Request, Response, Router } from "express";
import { verifyToken, verifyClientRole, verifyDriverRole } from '../middlewares/token.mdd';
import MainServer from '../classes/mainServer.class';
import MysqlClass from '../classes/mysqlConnect.class';
import { IBodyService } from '../interfaces/body_service.interface';
import reqIp from 'request-ip';
import h3 from "h3-js";
import { ListUserSockets } from '../classes/listUserSockets.class';
import { UserSocket } from '../classes/userSocket.class';

let TServiceRouter = Router();

let Server = MainServer.instance;
let Users = ListUserSockets.instance;
let MysqlCon = MysqlClass.instance;

TServiceRouter.get('/Journal/GetForHour', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    console.log(data);
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecificó las jornadas de tarifa'
            }
        });
    }

    res.json({
        ok: true,
        data
    });
                  
});

TServiceRouter.get('/Rate/GetForJournal', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecificó las jornadas de tarifa'
            }
        });
    }

    let sql = `CALL ts_sp_getRateForJournal(${ data.pkJournal });`;
    // console.log('sql tarifa ', sql);
    MysqlCon.onExecuteQuery(sql, (error: any, dataRate: any[]) => {

        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }

        res.json({
            ok: true,
            data: [{ dataRate }],
        });
    
      });
                  
});

TServiceRouter.post('/Service/Add', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    let body: IBodyService = req.body;
    let fkUser = req.userData.pkUser || 0;
    
    let indexHex = h3.geoToH3( body.coordsOrigin.lat, body.coordsOrigin.lng, Server.radiusPentagon );

    let sql = `CALL ts_sp_addService( `
    sql += `${ body.fkJournal }, `;
    sql += `${ body.fkRate }, `;
    sql += `${ body.fkCategory }, `;
    sql += `${ fkUser }, `;
    sql += `${ body.coordsOrigin.lat }, `;
    sql += `${ body.coordsOrigin.lng }, `;
    sql += `'${ body.streetOrigin }', `;
    sql += `${ body.coordsDestination.lat }, `;
    sql += `${ body.coordsDestination.lng }, `;
    sql += `'${ body.streetDestination }', `;
    sql += `${ body.distance }, `;
    sql += `'${ body.distanceText }', `;
    sql += `${ body.minutes }, `;
    sql += `'${ body.minutesText }', `;

    sql += `${ body.rateHistory }, `;
    sql += `${ body.rateService }, `;
    sql += `${ body.minRatePrc }, `;
    sql += `'${ body.paymentType }', `;
    sql += `'${ indexHex }', `;

    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        // enviar notificación a conductores cercanos
        const drivers: UserSocket[] =  Users.onGetDriverHex(indexHex);

        if (drivers.length > 0) {
            drivers.forEach( driver => {
                Server.io.to( driver.id ).emit('new-service', {data: data[0]});
            });
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });
});

TServiceRouter.get('/Culqui/Key', [verifyToken], (req: any, res: Response) => {
    
    let sql = `CALL cc_sp_getCulquiKey();`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: true,
                error
            });
        }

        res.json({
            ok: true,
            data: data[0]
        });
    });
});

TServiceRouter.get('/PercentRate', [verifyToken], (req: Request, res: Response) => {
    
    res.json({
        ok: true,
        data: [{percentRate: Server.getPercentRate()}]
    });

});

TServiceRouter.get('/Services/Driver', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {
    
    let page = req.query.page || 1;
    let fkUser = req.userData.pkUser || 0;

    let sql =  `CALL ts_sp_getServicesForDriver(${ page }, ${ fkUser });`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok: true,
            data
        });
    });

});

TServiceRouter.get('/Services/Driver/Total', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {

    let fkUser = req.userData.pkUser || 0;

    let sql =  `CALL ts_sp_overallPageServicesForDriver( ${ fkUser });`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok: true,
            total: data[0].total
        });

    });
});


export default TServiceRouter;
import { Request, Response, Router } from "express";
import { verifyToken, verifyClientRole } from '../middlewares/token.mdd';
import MainServer from '../classes/mainServer.class';
import MysqlClass from '../classes/mysqlConnect.class';
import { IBodyService } from '../interfaces/body_service.interface';
import reqIp from 'request-ip';

let TServiceRouter = Router();

let Server = MainServer.instance;
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

        MysqlCon.onExecuteQuery( sql, (errorConfig: any, data: any[]) =>{
            if (errorConfig) {
                return res.status(400).json({
                    ok: false,
                    error: errorConfig
                });
            }

            res.json({
                ok: true,
                data: [{ dataRate, config: data[0] }],
            });
    
            // res.json({
            //     ok: true,
            //     data: data[0]
            // });
        });
    
      });
                  
});

TServiceRouter.post('/Service/Add', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    let body: IBodyService = req.body;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL ts_sp_addService( `
    sql += `${ body.fkJournal }, `;
    sql += `${ body.fkRate }, `;
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
    sql += `${ body.rate }, `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) } );'`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        
        if (error) {
            return res.status(400).json({
                ok: false,
                error
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
export default TServiceRouter;
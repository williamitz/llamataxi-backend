import { Request, Response, Router } from "express";
import { verifyToken } from "../middlewares/token.mdd"
import MainServer from '../classes/mainServer.class';
import MysqlClass from '../classes/mysqlConnect.class';


let TaxiServiceRouter = Router();

let Server = MainServer.instance;
let MysqlCon = MysqlClass.instance;

TaxiServiceRouter.get('/Journal/GetForHour', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
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

TaxiServiceRouter.get('/Rate/GetForJournal', [verifyToken], (req: Request, res: Response) => {
    
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
    console.log('sql tarifa ', sql);
    MysqlCon.onExecuteQuery(sql, (error: any, dataRate: any[]) => {

        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
    
        res.json({
          ok: true,
          data: dataRate,
        });
    
      });
                  
});


export default TaxiServiceRouter;
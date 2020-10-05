import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import { verifyDriverRole, verifyClientRole } from '../middlewares/token.mdd';

let HistoryRouter = Router();

let MysqlCon = MysqlClass.instance;

HistoryRouter.get('/History/Driver', [verifyToken, verifyDriverRole], (req: any, res: Response) => {

    let fkUser = req.userData.pkUser || 0;
    let page = req.query.page || 1;

    let sql = `CALL ts_sp_getHistoryDriver( ${ fkUser }, ${ page } );`

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            total: data.length,
            data
        });

    });

});

HistoryRouter.get('/History/Detail/:id', [verifyToken], (req: any, res: Response) => {

    let pkService = req.params.id || 0;
    let page = req.query.page || 1;

    let sql = `CALL ts_sp_getDetailService( ${ pkService } );`

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            data: data[0]
        });

    });

});

HistoryRouter.get('/History/Client', [verifyToken, verifyClientRole], (req: any, res: Response) => {

    let fkUser = req.userData.pkUser || 0;
    let page = req.query.page || 1;

    let sql = `CALL ts_sp_getHistoryClient( ${ fkUser }, ${ page } );`

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            total: data.length,
            data
        });

    });

});

export default HistoryRouter;

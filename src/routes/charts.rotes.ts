import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import { verifyWebRoles } from '../middlewares/token.mdd';
import moment from 'moment';

let ChartsRouter = Router();

let MysqlCon = MysqlClass.instance;

ChartsRouter.get( '/NewUsers/Chart', [verifyToken, verifyWebRoles], (req: Request, res: Response) => {

    let sql = `CALL ch_sp_getChartCards();`

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

ChartsRouter.get( '/Services/Chart', [verifyToken, verifyWebRoles], (req: Request, res: Response) => {
    let month = req.query.month || moment().month() + 1;
    let yearParam = req.query.year || moment().year();

    let sql = `CALL ch_sp_getChartServices( ${ month }, ${ yearParam } );`

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

ChartsRouter.get( '/Users/Chart', [verifyToken, verifyWebRoles], (req: Request, res: Response) => {

    let month = req.query.month || moment().month() + 1;
    let yearParam = req.query.year || moment().year();

    let sql = `CALL ch_sp_getChartUsers( ${ month }, ${ yearParam } );`

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




export default ChartsRouter;
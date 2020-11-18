import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyWebmasterRole, verifyToken, verifyDriverClientRole, verifyDriverRole } from '../middlewares/token.mdd';
import reqIp from "request-ip";
import { ICoupon } from "../interfaces/body_coupon.interface";
import { IAccountDriver } from "../interfaces/body_accountDriver.interface";

let AccBankRouter = Router();

let MysqlCon = MysqlClass.instance;

AccBankRouter.get('/Bank', [verifyToken, verifyDriverRole], (req: Request, res: Response) => {
    
    let sql = `CALL ts_sp_getAllBank();`;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            data
        });

    });
    
});

AccBankRouter.get('/Account', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let pkDriverToken = req.userData.pkDriver || 0;
    let sql = `CALL ts_sp_getAccountDriver( ${ pkDriverToken } );`;

    // console.log( sql );

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            data
        });

    });
    
});

AccBankRouter.post('/Account', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let body: IAccountDriver = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkDriverToken = req.userData.pkDriver || 0;

    let sql = `CALL ts_sp_addAccountDriver(`;
    sql += `'${ body.ccAccount }', `;
    sql += `'${ body.cciAccount }', `;
    sql += `${ body.fkBank }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

    // IN `InAccountCC` varchar(20),
    // IN `InAccountCCI` varchar(30),
    // IN `InFkBank` varchar(40),
    // IN `InFkDriver` int,
    // IN `InFkUser` int,
    // IN `InIpUser` varchar(20))

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });
    
});

AccBankRouter.delete('/Account/:pk/:status', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let pkAccount = Number( req.params.pk ) || 0;
    let status = Boolean( req.params.status ) || true;
    let pkUserToken = req.userData.pkUser || 0;
    let pkDriverToken = req.userData.pkDriver || 0;

    let sql = `CALL ts_sp_deleteAccountDriver(`;
    sql += `${ pkAccount }, `;
    sql += `${ status }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });
    
});

export default AccBankRouter;
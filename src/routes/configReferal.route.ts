import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyWebRoles, verifyWebmasterRole, verifyToken } from '../middlewares/token.mdd';
import reqIp from "request-ip";
import { IconfigRef } from '../interfaces/body_configRef.interface';

let ReferalRouter = Router();

let MysqlCon = MysqlClass.instance;

ReferalRouter.get('/ConfigReferal', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {

    let sql = `CALL rb_sp_getConfig();`

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

ReferalRouter.post('/ConfigReferal', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let body: IconfigRef = req.body;

    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL rb_sp_updateConfig(`;
    sql += `${ body.bonnusClient }, `;
    sql += `${ body.bonnusDriver }, `;
    sql += `${ body.daysExpClient }, `;
    sql += `${ body.daysExpDriver }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }');`;

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

export default ReferalRouter;
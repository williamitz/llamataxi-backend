import {  Response, Router } from 'express';
import { INavPather } from '../interfaces/body_nav.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import { verifyToken } from '../middlewares/token.mdd';
import reqIp from 'request-ip';

let NavPaterRouter = Router();

let MysqlCnn = MysqlClass.instance;
                                    // middlware , verifyToken
NavPaterRouter.post( '/addNavPather' ,(req: any, res: Response) => {
    let body: INavPather = req.body;

    let userData = {pkUser: 1};  //req.userData;

    let sql = `CALL as_sp_addNavPahter( '${ body.navPatherText }', ${ userData.pkUser } , '${ reqIp.getClientIp(req) }' );`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

export default NavPaterRouter;
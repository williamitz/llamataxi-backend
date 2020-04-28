import { Request, Response, Router } from 'express';
import { verifyToken } from '../middlewares/token.mdd';
import { IBodyUser } from '../interfaces/body_user.interface';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';

let UserRouter = Router();
let MysqlCnn = MysqlClass.instance;

UserRouter.put('/user/updateProfile/:id', verifyToken, (req: any, res: Response) => {
    let body: IBodyUser = req.body;

    let pkParam = req.params.id || 0;

    let pkUserToken = req.userData.pkUser || 0;
    
    if (pkParam !== pkUserToken) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Fatal error, comuniquese con el web master'
            }
        });
    }


    // backtis Alt + 96

    let sql = `CALL as_sp_updateProfile( ${ pkParam }, ${ body.fkTypeDocument }, '${ body.document }', '${ body.name }', '${ body.surname }', '${ body.dateBirth }', ${ pkUserToken }, '${ reqIp.getClientIp(req) }' );`;

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

export default UserRouter;
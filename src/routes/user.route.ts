import { Request, Response, Router } from 'express';
import { verifyToken, verifyWebmasterRole } from '../middlewares/token.mdd';
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

UserRouter.get( '/User/Get', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {

    let InPage = req.query.page || 1;
    let rowsForPage = req.query.rowsForPage || 10;
    let qName = req.query.qName || '';
    let qEmail = req.query.qEmail || '';
    let qUser = req.query.qUser || '';
    let qRole = req.query.qRole || '';
    let showInactive = req.query.showInactive.toString() || 'true';

    let statusValid = ['true', 'false'];
    if (!statusValid.includes( showInactive )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: `Los estados válidos son ${ statusValid.join(', ') }`
            }
        });
    }

    let sql = `CALL as_sp_getListUser(${ InPage }, ${ rowsForPage }, '${ qName }', '${ qEmail }', '${ qUser }', '${ qRole }', ${ showInactive });`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let sqlOverall = `CALL as_sp_overallPageUser('${ qName }', '${ qEmail }', '${ qUser }', '${ qRole }', ${ showInactive });`;

        MysqlCnn.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[]) => {
            if (errorOverall) {
                return res.status(400).json({
                    ok: false,
                    error: errorOverall
                });
            }

            res.json({
                ok: true,
                total: dataOverall[0].total,
                data
            });
        });

    });

} );


export default UserRouter;
import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import reqIp from "request-ip";
import { verifyToken } from '../middlewares/token.mdd';
import { IMessage } from '../interfaces/body_message.interface';

let MessageRouter = Router();

let MysqlCon = MysqlClass.instance;

MessageRouter.post('/Message/Add', [verifyToken], (req: any, res: Response) => {
    let body: IMessage = req.body;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL as_sp_addMessage( ${body.fkUserEmisor}, ${body.fkUserReceptor}, '${body.subject}', '${ body.message }', '${ body.tags }',  ${fkUser}, '${reqIp.getClientIp(req)}' );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
    
        res.json({
          ok: true,
          showError: data[0].showError,
          data: data[0],
        });
    
    });
});

MessageRouter.get('/Message/Get', [verifyToken], (req: Request, res: Response) => {

    let pkUser = req.query.pkUser || 0;
    let page = req.query.page || 0;
    let rowsForPage = req.query.rowsForPage || 10;
    let showInactive = req.query.showInactive.toString() || 'true';

    let statusValid = ['true', 'false'];
    if (!statusValid.includes( showInactive )) {
        return res.status(400).json({
            ok:false,
            error: {
                message: 'Los estaos válidos son: ' + statusValid.join(', ')
            }
        });
    }

    let sql = `CALL as_sp_getListMessages( ${ pkUser }, ${ page }, ${ rowsForPage }, ${showInactive} );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }

        let sqlOverall = `CALL as_sp_overallPageMessages(${ pkUser }, ${showInactive});`;
        MysqlCon.onExecuteQuery(sql, (errorOverall: any, dataOverall: any[]) => {
            if (errorOverall) {
              return res.status(400).json({
                ok: false,
                error: errorOverall,
              });
            }
            res.json({
              ok: true,
              data,
              total: dataOverall[0].total
            });

        });
    });
});

export default MessageRouter;

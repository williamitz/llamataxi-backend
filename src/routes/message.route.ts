import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import reqIp from "request-ip";
import { verifyToken } from '../middlewares/token.mdd';
import { IMessage } from '../interfaces/body_message.interface';
import MainServer from '../classes/mainServer.class';
import { ListUserSockets } from "../classes/listUserSockets.class";

let MessageRouter = Router();
let mainServer = MainServer.instance;
let listUser = ListUserSockets.instance;

let MysqlCon = MysqlClass.instance;

MessageRouter.post('/Message/Add', [verifyToken], (req: any, res: Response) => {
    let body: IMessage = req.body;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL as_sp_addMessage(`;
    sql += `${fkUser}, `;
    sql += `${body.fkUserReceptor}, `;
    sql += `'${body.subject}', `;
    sql += `'${ body.message }', `;
    sql += `'${ body.tags }',  `;
    sql += `${fkUser}, `;
    sql += `'${reqIp.getClientIp(req)}' );`;
    
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

    let sql = `CALL as_sp_getListMessages(`;
    sql += `${ pkUser }, `;
    sql += `${ page }, `;
    sql += `${ rowsForPage }, `;
    sql += `${showInactive} );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }

        let sqlOverall = `CALL as_sp_overallPageMessages(${ pkUser }, ${showInactive});`;
        MysqlCon.onExecuteQuery(sqlOverall, (errorOverall: any, dataOverall: any[]) => {
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

MessageRouter.get('/Message/Get/Response/:id', [verifyToken], (req: any, res: Response) => {

  let pkMessage = req.params.id || 0;
  let fkUser = req.userData.pkUser || 0;

  let sql = `CALL as_sp_getListResponses( ${ pkMessage }, ${ fkUser } );`;
  
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {

      return res.status(400).json({
        ok: false,
        error
      });
      
    }

    res.json({
      ok: true,
      data
    });
      
  });
});

MessageRouter.post('/Message/Add/Response', [verifyToken], (req: any, res: Response) => {
  let body: IMessage = req.body;
  let fkUser = req.userData.pkUser || 0;

  let sql = `CALL as_sp_addResponseMsg( `;
  sql += `${ body.pkMessage }, `;
  sql += `${fkUser}, `;
  sql += `${body.fkUserReceptor}, `;
  sql += `'${ body.message }',  `;
  sql += `${fkUser}, `;
  sql += `'${reqIp.getClientIp(req)}' );`;
  
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

MessageRouter.get( '/Message/Total', [verifyToken], ( req: any, res: Response ) => {
  
  let fkUser = req.userData.pkUser || 0;
  
  let sql = `CALL as_sp_getTotalMsg( ${ fkUser } ); `;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

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

MessageRouter.put('/Message/Readed/:id', [verifyToken], (req: any, res: Response) => {

  let fkUser = req.userData.pkUser || 0;
  let pkMessage = req.params.id || 0;

  let sql = `CALL as_sp_updateReadedMsg( `;
  sql += `${ pkMessage }, `;
  sql += `${ fkUser }, `;
  sql += `'${ reqIp.getClientIp(req)}' );`;
  
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }

      if ( data[0].showError === 0 ) {
        const userSocket = listUser.onFindUserForPk( fkUser );
        if (userSocket.pkUser !== 0) {
          mainServer.io.in( userSocket.id ).emit('readed-msg', {});
        }
      }
  
      res.json({
        ok: true,
        showError: data[0].showError,
        data: data[0],
      });
  
  });

});

export default MessageRouter;

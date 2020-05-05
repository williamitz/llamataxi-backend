import { Response, Request, Router } from "express";
import { IBodyNotification } from "./../interfaces/body_notification.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let NotificationRouter = Router();

let MysqlCon = MysqlClass.instance;

NotificationRouter.get(
  "/getListNotification",
  (req: Request, res: Response) => {
    let body: IBodyNotification = req.body;
    let sql = `CALL as_sp_getListNotification( '${body.fkUserEmisor || ""}',
  '${body.fkUserReceptor || ""}',
  '${body.notificationTitle || ""}',
  '${body.sended || ""}', 
  '${body.readed || ""}');`;
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }

      res.json({
        ok: true,
        data: data,
      });
    });
  }
);

NotificationRouter.post("/addNotification", (req: any, res: Response) => {
  let body: IBodyNotification = req.body;

  let pkUserToken = 1; //req.userData.pkUser || 0;

  if (body.notificationTitle == null || body.fkUserEmisor == null) {
    return res.status(400).json({
      ok: false,
    });
  }

  let sql = `CALL as_sp_addNotification( ${body.fkUserEmisor || ""},
  ${body.fkUserReceptor || ""},
  '${body.notificationTitle || ""}',
  '${body.notificationSubTitle || ""}',
  '${body.notificationMessage || ""}', 
  '${body.dateSend || ""}', 
  '${body.dateReaded || ""}', 
   ${pkUserToken} , 
  '${reqIp.getClientIp(req)}' );`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    res.json({
      ok: true,
      data: data[0],
    });
  });
});

NotificationRouter.put("/updateNotification/:id", (req: any, res: Response) => {
  let body: IBodyNotification = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateNotification( ${pkParam}, 
    ${body.fkUserEmisor || ""},
  ${body.fkUserReceptor || ""},
  '${body.notificationTitle || ""}',
  '${body.notificationSubTitle || ""}',
  '${body.notificationMessage || ""}', 
  ${body.sended || ""}, 
  ${body.readed || ""}, 
  '${body.dateReaded || ""}', 
    ${pkUserToken} ,  
    '${reqIp.getClientIp(req)}');`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    res.json({
      ok: true,
      data: data[0],
    });
  });
});

NotificationRouter.delete(
  "/deleteNotification/:id/:statusRegister",
  (req: any, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNotification( '${pkParam}', 
      '${status}',
      ${pkUserToken} , 
      '${reqIp.getClientIp(req)}' );`;
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }
      res.json({
        ok: true,
        data: data[0],
      });
    });
  }
);
export default NotificationRouter;

import { Response, Request, Router } from "express";
import { IBodyNotification } from "./../interfaces/body_notification.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let NotificationRouter = Router();

let MysqlCon = MysqlClass.instance;

NotificationRouter.get("/Notification/Get", (req: Request, res: Response) => {
  let page = req.query.page || 1;
  let fkUserEmisor = req.query.fkUserEmisor || "";
  let fkUserReceptor = req.query.fkUserReceptor || "";
  let notificationTitle = req.query.notificationTitle || "";
  let sended = req.query.sended || 0;
  let readed = req.query.readed || 0;
  let showInactive = req.query.showInactive || true;

  let sql = `CALL as_sp_getListNotification( ${page},
    '${fkUserEmisor}',
  '${fkUserReceptor}',
  '${notificationTitle}',
  '${sended}', 
  '${readed}',
  ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    let sqlOverall = `CALL as_sp_overallPageNotification('${fkUserEmisor}',
      '${fkUserReceptor}',
      '${notificationTitle}',
      '${sended}', 
      '${readed}',${showInactive});`;
    MysqlCon.onExecuteQuery(
      sqlOverall,
      (errorOverall: any, dataOverall: any[]) => {
        if (errorOverall) {
          return res.status(400).json({
            ok: false,
            error: errorOverall,
          });
        }
        res.json({
          ok: true,
          data: data,
          total: dataOverall[0].total,
        });
      }
    );
  });
});

NotificationRouter.post("/Notification/Add", (req: any, res: Response) => {
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
      showError: data[0].showError,
      data: data[0],
    });
  });
});

NotificationRouter.put(
  "/Notification/Update/:id",
  (req: any, res: Response) => {
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
        showError: data[0].showError,
        data: data[0],
      });
    });
  }
);

NotificationRouter.delete(
  "/Notification/Delete/:id/:statusRegister",
  (req: any, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNotification( '${pkParam}', 
      ${status},
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
        showError: data[0].showError,
        data: data[0],
      });
    });
  }
);
export default NotificationRouter;

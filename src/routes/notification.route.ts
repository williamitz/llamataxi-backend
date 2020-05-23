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

  let sql = `CALL as_sp_getListNotification( ${page}, '${fkUserEmisor}', '${fkUserReceptor}',  '${notificationTitle}', '${sended}', '${readed}', ${showInactive});`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    let sqlOverall = `CALL as_sp_overallPageNotification('${fkUserEmisor}', '${fkUserReceptor}', '${notificationTitle}', '${sended}', '${readed}',${showInactive});`;

    MysqlCon.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[]) => {

        if (errorOverall) {
          return res.status(400).json({
            ok: false,
            error: errorOverall,
          });
        }

        res.json({
          ok: true,
          data,
          total: dataOverall[0].total,
        });

    });

  });

});

NotificationRouter.post("/Notification/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyNotification = req.body;

  let pkUserToken = req.userData.pkUser || 0;

  /**
   * IN `InPkUserEmisor` INT,
      IN `InPkUserReceptor` INT,
      IN `InNotificationTitle` VARCHAR(255),
      IN `InNotificationSubTitle` VARCHAR(255),
      IN `InNotificationMessage` VARCHAR(255),
      IN `InPkUser` INT,
      IN `InIpUser` VARCHAR(20))
   * 
   */

  let sql = `CALL as_sp_addNotification( ${body.fkUserEmisor}, ${body.fkUserReceptor}, '${body.notificationTitle}', '${body.notificationSubTitle}', '${body.notificationMessage}', ${pkUserToken} , 
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

NotificationRouter.put( "/Notification/Update/:id", (req: any, res: Response) => {

    let body: IBodyNotification = req.body;

    let pkParam = req.params.id || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateNotification( ${pkParam}, ${body.fkUserEmisor},  ${body.fkUserReceptor}, '${body.notificationTitle}',  '${body.notificationSubTitle}', '${body.notificationMessage}', ${body.sended}, ${body.readed}, '${body.dateReaded}', ${pkUserToken} , '${reqIp.getClientIp(req)}');`;

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

NotificationRouter.get( '/Notification/Get/Receptor', [verifyToken], (req: any, res: Response) => {
  
  let pkUser = req.userData.pkUser || 0;
  let sql = `CALL as_sp_getNotifyReceptor(${ pkUser });`;
  MysqlCon.onExecuteQuery(sql, ( error: any, data: any[] ) => {

    if (error) {
      return res.status(400).json({
        ok: true,
        error
      });
    }

    res.json({
      ok: true,
      data
    });

  });

});

NotificationRouter.put('/Notification/Readed/:id', [verifyToken], (req: any, res: Response) => {
  
  let pkNoti = req.params.id || 0;
  let pkUser = req.userData.pkUser || 0;
  
  let sql = `CALL as_sp_updateReadedNoti(${ pkNoti }, ${ pkUser }, '${ reqIp.getClientIp(req) }')`;

  MysqlCon.onExecuteQuery(sql, ( error: any, data: any[] ) => {

    if (error) {
      return res.status(400).json({
        ok: true,
        error
      });
    }

    res.json({
      ok: true,
      showError: data[0].showError
    });

  });

});
export default NotificationRouter;

import { Request, Response, Router } from "express";
import { IBodyApplication } from "./../interfaces/body_application.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let ApplicationRouter = Router();

let MysqlCon = MysqlClass.instance;

ApplicationRouter.get("/getListApplication", (req: Request, res: Response) => {
  let body: IBodyApplication = req.body;
  let sql = `CALL as_sp_getListApplication(${body.statusRegister || 2});`;
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
});

ApplicationRouter.post("/addApplication", (req: any, res: Response) => {
  let body: IBodyApplication = req.body;

  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addApplication( '${body.nameApp || ""}',    
    '${body.description || ""}',
    '${body.languaje || ""}',
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
ApplicationRouter.put("/updateApplication/:id", (req: any, res: Response) => {
  let body: IBodyApplication = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateApplication( ${pkParam}, 
    '${body.nameApp || ""}',   
    '${body.description || ""}',   
    '${body.languaje || ""}',   
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

ApplicationRouter.delete(
  "/deleteApplication/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteApplication( '${pkParam}', 
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
export default ApplicationRouter;

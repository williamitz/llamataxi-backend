import { Request, Response, Router } from "express";
import { IBodyModel } from "./../interfaces/body_model.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
let ModelRouter = Router();

let MysqlCon = MysqlClass.instance;

ModelRouter.get("/getListModel", (req: Request, res: Response) => {
  let body: IBodyModel = req.body;
  let sql = `CALL as_sp_getListModel('${body.fkCategory || ""}',
  '${body.fkBrand || ""}',
  '${body.nameModel || ""}',
  '${body.statusRegister || 2}');`;
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

ModelRouter.post("/addModel", (req: any, res: Response) => {
  let body: IBodyModel = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addModel( ${body.fkCategory || ""},
    ${body.fkBrand || ""},
    '${body.nameModel || ""}',
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

ModelRouter.put("/updateModel/:id", (req: any, res: Response) => {
  let body: IBodyModel = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateModel( ${pkParam}, 
    ${body.fkCategory || ""},
    ${body.fkBrand || ""},
    '${body.nameModel || ""}',  
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

ModelRouter.delete(
  "/deleteModel/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteModel( '${pkParam}', 
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
export default ModelRouter;

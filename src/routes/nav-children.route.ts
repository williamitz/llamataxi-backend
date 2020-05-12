import { Request, Response, Router } from "express";
import { IBodyNavChildren } from "./../interfaces/body_nav_children.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyWebmasterRole, verifyToken } from "../middlewares/token.mdd";
import reqIp from "request-ip";

let NavChildrenRouter = Router();

let MysqlCon = MysqlClass.instance;

NavChildrenRouter.get(
  "/NavChildren/Get",
  //[verifyToken, verifyWebmasterRole],
  (req: Request, res: Response) => {
    let page = req.query.page || 1;
    let q = req.query.q || "";
    let showInactive = req.query.showInactive || true;
    let sql = `CALL as_sp_getListNavChildren(${page},'${q}',
    ${showInactive});`;
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }
      let sqlOverall = `CALL as_sp_overallPageNavChildren('${q}', ${showInactive});`;

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
  }
);
NavChildrenRouter.get("/NavChildren/GetAll", (req: Request, res: Response) => {
  let sql = `CALL as_sp_getListNavChildrenAll();`;
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
NavChildrenRouter.post(
  "/NavChildren/Add",
  //[verifyToken, verifyWebmasterRole],
  (req: any, res: Response) => {
    let body: IBodyNavChildren = req.body;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL as_sp_addNavChildren( ${body.fkNavFather || ""},
  '${body.navChildrenText || ""}',
  '${body.navChildrenPath || ""}',
  '${body.navChildrenIcon || ""}' ,  
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

NavChildrenRouter.put(
  "/NavChildren/Update/:id",
  [verifyToken, verifyWebmasterRole],
  (req: any, res: Response) => {
    let body: IBodyNavChildren = req.body;

    let pkParam = req.params.id || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateNavChildren( ${pkParam}, 
    '${body.fkNavFather || ""}',
  '${body.navChildrenText || ""}',
  '${body.navChildrenPath || ""}',
  '${body.navChildrenIcon || ""}',    
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

NavChildrenRouter.delete(
  "/NavChildren/Delete/:id/:statusRegister",
  //[verifyToken, verifyWebmasterRole],
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNavChildren( '${pkParam}', 
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
        status: req.params.statusRegister,
        status2: status,
      });
    });
  }
);

export default NavChildrenRouter;

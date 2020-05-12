import { Request, Response, Router } from "express";
import { IBodyMenuRole } from "./../interfaces/body_menu_role.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let MenuRoleRouter = Router();

let MysqlCon = MysqlClass.instance;

MenuRoleRouter.get("/MenuRole/Get", (req: Request, res: Response) => {
  let page = req.query.page || 1;
  let fkNavChildren = req.query.fkNavChildren || 0;
  let role = req.query.role || "";
  let showInactive = req.query.showInactive || true;
  let sql = `CALL as_sp_getListMenuRole(${page},${fkNavChildren},
  '${role}',
  ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL as_sp_overallPageMenuRole(${fkNavChildren},
      '${role}', ${showInactive});`;

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

MenuRoleRouter.post("/MenuRole/Add", (req: any, res: Response) => {
  let body: IBodyMenuRole = req.body;

  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addMenuRole( '${body.fkNavChildren || ""}',
    '${body.role || ""}',
     ${pkUserToken}, 
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

MenuRoleRouter.put("/MenuRole/Update/:id", (req: any, res: Response) => {
  let body: IBodyMenuRole = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateMenuRole( ${pkParam}, 
    ${body.fkNavChildren || ""},   
    '${body.role || ""}',   
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

MenuRoleRouter.delete(
  "/MenuRole/Delete/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteMenuRole( '${pkParam}', 
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
export default MenuRoleRouter;

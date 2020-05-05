import { Request, Response, Router } from "express";
import { IBodyMenuRole } from "./../interfaces/body_menu_role.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let MenuRoleRouter = Router();

let MysqlCon = MysqlClass.instance;

MenuRoleRouter.get("/getListMenuRole", (req: Request, res: Response) => {
  let body: IBodyMenuRole = req.body;
  let sql = `CALL as_sp_getListMenuRole('${body.fkNavChildren || ""}',
  '${body.role || ""}',
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

MenuRoleRouter.post("/addMenuRole", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

MenuRoleRouter.put("/updateMenuRole/:id", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

MenuRoleRouter.delete(
  "/deleteMenuRole/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteMenuRole( '${pkParam}', 
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
export default MenuRoleRouter;

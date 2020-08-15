import { Request, Response, Router } from "express";
import { IBodyMenuRole } from "./../interfaces/body_menu_role.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let MenuRoleRouter = Router();

let MysqlCon = MysqlClass.instance;

MenuRoleRouter.get("/MenuRole/Get", (req: Request, res: Response) => {
  let page = req.query.page || 1;
  let qNav = req.query.qNav || '';
  let qRole = req.query.qRole || '';
  let showInactive = req.query.showInactive || true;

  let sql = `CALL as_sp_getListMenuRole(${page}, '${qNav}', '${qRole}', ${showInactive});`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    let sqlOverall = `CALL as_sp_overallPageMenuRole('${qNav}','${qRole}', ${showInactive});`;

    MysqlCon.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[] ) => {

        if (errorOverall) {
          return res.status(400).json({
            ok: false,
            error: errorOverall
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

MenuRoleRouter.delete( "/MenuRole/Delete/:id/:statusRegister", (req: Request, res: Response) => {
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
});

MenuRoleRouter.get('/MenuRole/Get/Web', [verifyToken], (req: any, res: Response) =>{
  let fkUser = req.userData.pkUser || 0;
  let roleUser = req.userData.role || 'none_role';

  let sql = `CALL as_sp_getMenuForRole(${ fkUser }, '${ roleUser }');`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    res.json({
      ok: true,
      data,
    });
  });
});

MenuRoleRouter.post('/MenuRole/Allow', [verifyToken], (req: any, res: Response) => {
  let body = req.body;
  let url = body.url || 'xD';
  let fkUser = req.userData.pkUser || 0;
  let roleUser = req.userData.role || 'none_role';

  let sql = `CALL as_sp_getAllowMenu(${ fkUser }, '${ roleUser }', '${ url }');`;

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
      data: data[0]
    });

  });

});

export default MenuRoleRouter;

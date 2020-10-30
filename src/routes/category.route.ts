import { Request, Response, Router } from "express";
import { IBodyCategory } from "./../interfaces/body_category.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let CategoryRouter = Router();

let MysqlCon = MysqlClass.instance;

CategoryRouter.get("/Category/Get", [verifyToken], (req: Request, res: Response) => {
  let body: IBodyCategory = req.body;
  let showInactive = req.query.showInactive || true;
  let sql = `CALL as_sp_getListCategory(${showInactive});`;

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
      total: data.length,
    });
  });
});
CategoryRouter.get("/Category/GetAll", [verifyToken], (req: Request, res: Response) => {
  let sql = `CALL as_sp_getListCategoryAll();`;
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

CategoryRouter.post("/Category/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyCategory = req.body;

  let pkUserToken = 1; //req.userData.pkUser || 0;
  let sql = `CALL as_sp_addCategory( '${body.nameCategory || ""}',   
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

CategoryRouter.put("/Category/Update/:id", [verifyToken], (req: any, res: Response) => {
  let body: IBodyCategory = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateCategory( ${pkParam}, 
    '${body.nameCategory || ""}',   
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

CategoryRouter.delete(
  "/Category/Delete/:id/:statusRegister",
  [verifyToken],
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteCategory( '${pkParam}', 
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

export default CategoryRouter;

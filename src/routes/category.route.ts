import { Request, Response, Router } from "express";
import { IBodyCategory } from "./../interfaces/body_category.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let CategoryRouter = Router();

let MysqlCon = MysqlClass.instance;

CategoryRouter.get("/getListCategory", (req: Request, res: Response) => {
  let body: IBodyCategory = req.body;
  let sql = `CALL as_sp_getListCategory();`;
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

CategoryRouter.post("/addCategory", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

CategoryRouter.put("/updateCategory/:id", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

CategoryRouter.delete("/deleteCategory/:id", (req: Request, res: Response) => {
  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;
  let sql = `CALL as_sp_deleteCategory( '${pkParam}', 
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

export default CategoryRouter;

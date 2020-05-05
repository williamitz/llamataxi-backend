import { Request, Response, Router } from "express";
import { IBodyBrand } from "./../interfaces/body_brand.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let BrandRouter = Router();

let MysqlCon = MysqlClass.instance;

BrandRouter.get("/getListBrand", (req: Request, res: Response) => {
  let body: IBodyBrand = req.body;
  let sql = `CALL as_sp_getListBrand(${body.fkCategory || null},
  '${body.nameBrand || ""}',
  ${body.statusRegister || 2});`;
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

BrandRouter.post("/addBrand", (req: any, res: Response) => {
  let body: IBodyBrand = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addBrand( ${body.fkCategory || ""},    
    '${body.nameBrand || ""}',
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

BrandRouter.put("/updateBrand/:id", (req: any, res: Response) => {
  let body: IBodyBrand = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateBrand( ${pkParam}, 
    ${body.fkCategory || ""},   
    '${body.nameBrand || ""}',   
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

BrandRouter.delete(
  "/deleteBrand/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteBrand( '${pkParam}', 
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

export default BrandRouter;

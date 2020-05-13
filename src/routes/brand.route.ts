import { Request, Response, Router } from "express";
import { IBodyBrand } from "./../interfaces/body_brand.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let BrandRouter = Router();

let MysqlCon = MysqlClass.instance;

BrandRouter.get("/Brand/Get", (req: Request, res: Response) => {
  let page = req.query.page || 1;
  let fkCategory = req.query.fkCategory || 0;
  let nameBrand = req.query.nameBrand || "";
  let showInactive = req.query.showInactive || true;
  let sql = `CALL as_sp_getListBrand(${page},${fkCategory},
  '${nameBrand}',
  ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL as_sp_overallPageBrand(${fkCategory},
      '${nameBrand}',
      ${showInactive});`;

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
BrandRouter.get("/Brand/GetAll", (req: Request, res: Response) => {
  let sql = `CALL as_sp_getListBrandAll();`;
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
BrandRouter.post("/Brand/Add", (req: any, res: Response) => {
  let body: IBodyBrand = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addBrand( ${body.fkCategory},    
    '${body.nameBrand}',
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

BrandRouter.put("/Brand/Update/:id", (req: any, res: Response) => {
  let body: IBodyBrand = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateBrand( ${pkParam}, 
    ${body.fkCategory},   
    '${body.nameBrand}',   
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

BrandRouter.delete(
  "/Brand/Delete/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteBrand( '${pkParam}', 
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

export default BrandRouter;

import { Request, Response, Router } from "express";
import { IBodyBrand } from "./../interfaces/body_brand.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let BrandRouter = Router();

let MysqlCon = MysqlClass.instance;

BrandRouter.get("/Brand/Get", [verifyToken], (req: Request, res: Response) => {
  let page = Number( req.query.page ) || 1;
  let qCategory = req.query.qCategory || "";
  let qBrand = req.query.qBrand || "";
  

  let showInactive = req.query.showInactive || true;

  let sql = `CALL as_sp_getListBrand(${page}, '${qCategory}', '${ qBrand }', ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL as_sp_overallPageBrand( '${qCategory}', '${ qBrand }', ${showInactive});`;

    MysqlCon.onExecuteQuery(sqlOverall, (errorOverall: any, dataOverall: any[]) => {
        if (errorOverall) {
          return res.status(400).json({
            ok: false,
            error: errorOverall,
          });
        }

        res.json({
          ok: true,
          data,
          total: dataOverall[0].total,
        });
      }
    );
  });
});

BrandRouter.get("/Brand/GetAll", [verifyToken], (req: Request, res: Response) => {

  let fkCategory = req.query.fkCategory || 0;

  let sql = `CALL as_sp_getListBrandAll(${ fkCategory });`;

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
BrandRouter.post("/Brand/Add", [verifyToken], (req: any, res: Response) => {
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

BrandRouter.put("/Brand/Update/:id", [verifyToken], (req: any, res: Response) => {
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
  "/Brand/Delete/:id/:statusRegister", [verifyToken],
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

import { Request, Response, Router } from "express";
import { IBodyModel } from "./../interfaces/body_model.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
let ModelRouter = Router();

let MysqlCon = MysqlClass.instance;

ModelRouter.get("/Model/Get", [verifyToken], (req: Request, res: Response) => {
  let page = req.query.page || 1;
  let fkCategory = req.query.fkCategory || 0;
  let fkBrand = req.query.fkBrand || 0;
  let nameModel = req.query.nameModel || "";
  let showInactive = req.query.showInactive || true;

  let sql = `CALL as_sp_getListModel(${page},'${fkCategory}', '${fkBrand}', '${nameModel}', ${showInactive});`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    let sqlOverall = `CALL as_sp_overallPageModel('${fkCategory}', '${fkBrand}', '${nameModel}',${showInactive});`;

    MysqlCon.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[]) => {

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

ModelRouter.get("/Model/GetAll", [verifyToken], (req: Request, res: Response) => {
  let fkCategory = req.query.fkCategory || 0;
  let fkBrand = req.query.fkBrand || 0;

  let sql = `CALL as_sp_getListModelAll(${ fkCategory }, ${ fkBrand });`;
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

ModelRouter.post("/Model/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyModel = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addModel( ${body.fkCategory}, `;
  sql += `${body.fkBrand}, `;
  sql += `'${body.nameModel}', `;
  sql += `${pkUserToken} , `;
  sql += `'${reqIp.getClientIp(req)}' );`;  

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

ModelRouter.put("/Model/Update/:id", [verifyToken], (req: any, res: Response) => {
  let body: IBodyModel = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateModel( ${pkParam}, `;

    sql += `${body.fkCategory}, `;
    sql += `${body.fkBrand},`;
    sql += `'${body.nameModel}', `;
    sql += `${pkUserToken} , `;
    sql += `'${reqIp.getClientIp(req)}' );`;

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

ModelRouter.delete(
  "/Model/Delete/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteModel( '${pkParam}', 
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
export default ModelRouter;

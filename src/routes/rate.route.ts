import { Request, Response, Router } from "express";

import { IBodyRate } from '../interfaces/body_rate.interface';
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let RateRouter = Router();

let MysqlCon = MysqlClass.instance;

RateRouter.get("/Rate/Get", [verifyToken], (req: Request, res: Response) => {
  let page = Number( req.query.page ) || 1;
  let qCategory = req.query.qCategory || "";
  let qJournal = req.query.qJournal || ""; 

  let showInactive = req.query.showInactive || true;
  let sql = `CALL cc_sp_getListRate(${page}, '${qCategory}', '${ qJournal }', ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL cc_sp_overallPageRate( '${qCategory}', '${ qJournal }', ${showInactive});`;

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

RateRouter.get("/Rate/GetAll", [verifyToken], (req: Request, res: Response) => {

  let fkCategory = req.query.fkCategory || 0;

  let sql = `CALL cc_sp_getListRateAll(${ fkCategory });`;

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
RateRouter.post("/Rate/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyRate = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL cc_sp_addRate( ${body.fkCategory}, ${body.fkJournal}, ${body.priceRate}, ${pkUserToken},'${reqIp.getClientIp(req)}' );`;

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

RateRouter.put("/Rate/Update/:id", [verifyToken], (req: any, res: Response) => {
  let body: IBodyRate = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL cc_sp_updateRate( ${pkParam}, ${body.fkCategory}, ${body.fkJournal}, ${body.priceRate}, ${pkUserToken}, '${reqIp.getClientIp(req)}');`;

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

RateRouter.delete("/Rate/Delete/:id/:statusRegister", [verifyToken], (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL cc_sp_deleteRate( '${pkParam}', ${status}, ${pkUserToken}, '${reqIp.getClientIp(req)}' );`;

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

export default RateRouter;

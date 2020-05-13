import { Request, Response, Router } from "express";
import { IBodyApplication } from "./../interfaces/body_application.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import reqIp from "request-ip";
import { verifyWebmasterRole, verifyToken } from '../middlewares/token.mdd';

let ApplicationRouter = Router();

let MysqlCon = MysqlClass.instance;

ApplicationRouter.get("/Application/Get", [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {

  let page = req.query.page || 1;
  let q = req.query.q || '';
  let showInactive = req.query.showInactive || true;
  
  let sql = `CALL as_sp_getListApplication(${ page }, '${ q }', ${ showInactive });`;
  
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error
      });
    }

    let sqlOverall = `CALL as_sp_overallPageApplication('${ q }', ${ showInactive });`;

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
        total: dataOverall[0].total
      });

    });

  });

});

ApplicationRouter.post("/Application/Add", [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
  let body: IBodyApplication = req.body;

  let fkUser = req.userData.pkUser || 0;

  let sql = `CALL as_sp_addApplication( '${body.nameApp}', '${body.description}', '${body.plattform}',  ${fkUser}, '${reqIp.getClientIp(req)}' );`;

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

ApplicationRouter.put("/Application/Update/:id", [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
  let body: IBodyApplication = req.body;

  let pkParam = req.params.id || 0;
  let fkUser = req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateApplication( ${pkParam}, '${body.nameApp}', '${body.description}', '${body.plattform}',  ${fkUser} , '${reqIp.getClientIp(req)}' );`;

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

ApplicationRouter.delete( "/Application/Delete/:id/:statusRegister", [verifyToken, verifyWebmasterRole],
  (req: any, res: Response) => {

    let pkApp = req.params.id || 0;
    let status = req.params.statusRegister || 'true';
    let fkUser = req.userData.pkUser || 0;

    let statusValid = ['true', 'false'];

    if (!statusValid.includes( status ) ) {
      return res.status(400).json({
        ok: false,
        error: {
          message: 'Los estados válidos son ' + statusValid.join(', ')
        }
      });
    }

    let sql = `CALL as_sp_deleteApplication( '${pkApp}', ${status}, ${fkUser} , '${reqIp.getClientIp(req)}' );`;

    console.log(sql);
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
export default ApplicationRouter;

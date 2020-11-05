import { Request, Response, Router } from "express";
import { IBodyJournal } from "./../interfaces/body_journal.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import MainServer from "../classes/mainServer.class";

let JournalRouter = Router();
let mainServer = MainServer.instance;
let MysqlCon = MysqlClass.instance;

JournalRouter.get("/Journal/Get", [verifyToken], (req: Request, res: Response) => {

  let showInactive = req.query.showInactive || true;
  let sql = `CALL cc_sp_getListJournal(${showInactive});`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error
      });
    }

    res.json({
      ok: true,
      data: data,
      total: data.length
    });

  });

});

JournalRouter.get("/Journal/GetAll", [verifyToken], (req: Request, res: Response) => {

  let sql = `CALL cc_sp_getListJournalAll();`;

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

JournalRouter.post("/Journal/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyJournal = req.body;
  let pkUserToken = req.userData.pkUser || 0;

  let codsValid = ['DIURN', 'NOCTURN'];

  if (!codsValid.includes( body.codeJournal )) {
    return res.status(400).json({
      ok: false,
      error: {
        message: 'Los códigos válidos son ' + codsValid.join(', ')
      },
    });
  }

  let sql = `CALL cc_sp_addJournal( '${body.nameJournal}', '${body.codeJournal}', '${body.hourStart}', '${body.hourEnd}',${pkUserToken} ,'${reqIp.getClientIp(req)}' );`;

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

JournalRouter.put("/Journal/Update/:id", [verifyToken], (req: any, res: Response) => {
  let body: IBodyJournal = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = req.userData.pkUser || 0;

  let sql = `CALL cc_sp_updateJournal( ${pkParam}, '${body.nameJournal}', '${body.codeJournal}','${body.hourStart }', '${body.hourEnd }', ${pkUserToken} ,'${reqIp.getClientIp(req)}' );`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    if (data[0].showError === 0) {
      mainServer.loadJournal();
      // mainServer.listenJournal();
    }

    res.json({
      ok: true,
      showError: data[0].showError,
      data: data[0],
    });
  
  });

});

JournalRouter.delete( "/Journal/Delete/:id/:statusRegister", [verifyToken], (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL cc_sp_deleteJournal( '${pkParam}', ${status}, ${pkUserToken}, '${reqIp.getClientIp(req)}' );`;

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

export default JournalRouter;

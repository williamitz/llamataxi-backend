import { Response, Router } from "express";
import { INavFather } from "../interfaces/body_nav.interface";
import MysqlClass from "../classes/mysqlConnect.class";
import { verifyToken } from "../middlewares/token.mdd";
import reqIp from "request-ip";

let NavFatherRouter = Router();

let MysqlCon = MysqlClass.instance;
// middlware , verifyToken
NavFatherRouter.get("/NavFather/Get", (req: any, res: Response) => {
  let page = req.query.page || 1;
  let q = req.query.q || "";
  let showInactive = req.query.showInactive || true;
  let sql = `CALL as_sp_getListNavFather(${page},'${q}',
      ${showInactive});`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL as_sp_overallPageNavFather('${q}', ${showInactive});`;

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

NavFatherRouter.post("/NavFather/Add", (req: any, res: Response) => {
  let body: INavFather = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addNavFahter( '${body.navFatherText}', 
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

NavFatherRouter.put("/NavFather/Update/:id", (req: any, res: Response) => {
  let body: INavFather = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateNavFather( ${pkParam}, 
    '${body.navFatherText}',
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

NavFatherRouter.delete(
  "/NavFather/Delete/:id/:statusRegister",
  (req: any, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNavFather( '${pkParam}', 
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

NavFatherRouter.get("/NavFather/GetAll", (req: any, res: Response) => {
  let sql = `CALL as_sp_getListNavFatherAll();`;
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

export default NavFatherRouter;

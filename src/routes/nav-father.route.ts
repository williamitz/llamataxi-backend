import { Response, Router } from "express";
import { INavFather } from "../interfaces/body_nav.interface";
import MysqlClass from "../classes/mysqlConnect.class";
import { verifyToken } from "../middlewares/token.mdd";
import reqIp from "request-ip";

let NavFatherRouter = Router();

let MysqlCon = MysqlClass.instance;
// middlware , verifyToken
NavFatherRouter.get("/getListNavFather", (req: any, res: Response) => {
  let body: INavFather = req.body;
  let sql = `CALL as_sp_getListNavFather('${body.navFatherText || ""}',
      '${body.statusRegister || 2}');`;
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

NavFatherRouter.post("/addNavFather", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

NavFatherRouter.put("/updateNavFather/:id", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

NavFatherRouter.delete(
  "/deleteNavFather/:id/:statusRegister",
  (req: any, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNavFather( '${pkParam}', 
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
export default NavFatherRouter;

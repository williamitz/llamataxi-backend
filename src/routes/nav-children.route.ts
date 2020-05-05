import { Request, Response, Router } from "express";
import { IBodyNavChildren } from "./../interfaces/body_nav_children.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let NavChildrenRouter = Router();

let MysqlCon = MysqlClass.instance;

NavChildrenRouter.get("/getListNavChildren", (req: Request, res: Response) => {
  let body: IBodyNavChildren = req.body;
  let sql = `CALL as_sp_getListNavChildren('${body.fkNavFather || ""}',
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

NavChildrenRouter.post("/addNavChildren", (req: any, res: Response) => {
  let body: IBodyNavChildren = req.body;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_addNavChildren( ${body.fkNavFather || ""},
  '${body.navChildrenText || ""}',
  '${body.navChildrenPath || ""}',
  '${body.navChildrenIcon || ""}' ,  
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

NavChildrenRouter.put("/updateNavChildren/:id", (req: any, res: Response) => {
  let body: IBodyNavChildren = req.body;

  let pkParam = req.params.id || 0;
  let pkUserToken = 1; //req.userData.pkUser || 0;

  let sql = `CALL as_sp_updateNavChildren( ${pkParam}, 
    '${body.fkNavFather || ""}',
  '${body.navChildrenText || ""}',
  '${body.navChildrenPath || ""}',
  '${body.navChildrenIcon || ""}',    
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

NavChildrenRouter.delete(
  "/deleteNavChildren/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteNavChildren( '${pkParam}', 
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
export default NavChildrenRouter;

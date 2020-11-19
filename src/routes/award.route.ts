import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken, verifyWebRoles } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { IAward } from "../interfaces/body_award.interface";

let AwardRouter = Router();

let MysqlCon = MysqlClass.instance;

AwardRouter.get("/Awards", [verifyToken, verifyWebRoles], (req: Request, res: Response) => {
    let page = Number( req.query.page ) || 1;
    let rowsForPage = Number( req.query.rowsForPage ) || 1;
    let qName = req.query.qName || "";
    
    let showInactive = req.query.showInactive || true;
  
    let sql = `CALL aw_sp_getListAwards(`;
    sql += `${page},`;
    sql += `${rowsForPage},`;
    sql += `'${qName}',`;
    sql += `${showInactive}); `;

    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        let sqlOverall = `CALL aw_sp_overallPageAwards( `;
        sqlOverall += `'${qName}',`;
        sqlOverall += `${showInactive}); `;
  
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

AwardRouter.post("/Award", [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    let body: IAward = req.body;
    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL aw_sp_addAward(`;
    sql += `'${ body.nameAward }',`;
    sql += `'${ body.description }',`;
    sql += `${ body.points },`;
    sql += `${ body.stock },`;
    sql += `${ pkUserToken },`;
    sql += `'${ reqIp.getClientIp( req ) }' ); `;

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
            data: data[0]
        });  
      
    });
});

AwardRouter.put("/Award/:pk", [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    let body: IAward = req.body;
    let pkAward = req.params.pk || 0;
    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL aw_sp_updateAward(`;
    sql += `${ pkAward },`;
    sql += `'${ body.nameAward }',`;
    sql += `'${ body.description }',`;
    sql += `${ body.points },`;
    sql += `${ body.stock },`;
    sql += `${ pkUserToken },`;
    sql += `'${ reqIp.getClientIp( req ) }' ); `;

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
            data: data[0]
        });  
      
    });
});

AwardRouter.delete("/Award/:pk/:status", [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    
    let pkAward = req.params.pk || 0;
    let status = req.params.status || true;
    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL aw_sp_deleteAward(`;
    sql += `${ pkAward },`;
    sql += `${status },`;
    sql += `${ pkUserToken },`;
    sql += `'${ reqIp.getClientIp( req ) }' ); `;

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
            data: data[0]
        });  
      
    });
});

export default AwardRouter;
import { Request, Response, Router } from "express";
import { IBodyBrand } from "./../interfaces/body_brand.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { IConfJournal } from "../interfaces/body_cJournal.interface";

let CJouRouter = Router();

let MysqlCon = MysqlClass.instance;

CJouRouter.get("/ConfigJournal", [verifyToken], (req: Request, res: Response) => {

    let page = Number( req.query.page ) || 1;
    let showInactive = req.query.showInactive || true;
  
    let sql = `CALL cc_sp_getListCJournal( ${page}, ${showInactive} );`;

    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

      let sqlOverall = `CALL cc_sp_overallPageCJournal( ${showInactive} );`;
  
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

        });

    });
});

CJouRouter.post("/ConfigJournal", [verifyToken], (req: Request, res: Response) => {

    let body: IConfJournal = req.body;
  
    let sql = `CALL cc_sp_getListCJournal(  );`;

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

export default CJouRouter;
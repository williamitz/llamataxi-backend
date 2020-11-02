import { Request, Response, Router } from "express";
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

CJouRouter.post("/ConfigJournal", [verifyToken], (req: any, res: Response) => {

    let body: IConfJournal = req.body;
    let pkUserToken = req.userData.pkUser || 0;

    let modesValid = ['FORTODAY', 'FORSERVI'];

    if (!modesValid.includes( body.mode )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los modos válidos son ' + modesValid.join(', ')
            },
        });
    }
  
    let sql = `CALL cc_sp_addConfigJournal( `;
    sql += `'${ body.name }', `;
    sql += `${ body.rate }, `;
    sql += `'${ body.mode }', `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

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

CJouRouter.put("/ConfigJournal/:pk", [verifyToken], (req: any, res: Response) => {

    let body: IConfJournal = req.body;
    let pkConfig = req.params.pk || 0;
    let pkUserToken = req.userData.pkUser || 0;

    let modesValid = ['FORTODAY', 'FORSERVI'];

    if (!modesValid.includes( body.mode )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los modos válidos son ' + modesValid.join(', ')
            },
        });
    }
  
    let sql = `CALL cc_sp_addConfigJournal( `;
    sql += `${ pkConfig }, `;
    sql += `'${ body.name }', `;
    sql += `${ body.rate }, `;
    sql += `'${ body.mode }', `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

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

CJouRouter.delete("/ConfigJournal/:pk/:status", [verifyToken], (req: any, res: Response) => {

    let pkConfig = req.params.pk || 0;
    let status = req.params.status || true;
    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL cc_sp_deleteConfigJournal( `;
    sql += `${ pkConfig }, `;
    sql += `${ status }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

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
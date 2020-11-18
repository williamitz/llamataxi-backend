import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { verifyWebRoles } from '../middlewares/token.mdd';
import moment from 'moment';

let LiquRouter = Router();
let MysqlCon = MysqlClass.instance;

LiquRouter.get('/Liquidation', [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    
    let page = Number( req.query.page ) || 1;
    let rowsForPage = Number( req.query.rowsForPage ) || 10;
    let qName = req.query.qName || "";
  
    let showInactive = req.query.showInactive || true;

    let sql = `CALL ts_sp_getJournalDriverWeb( `;
    sql += `${ page },`;
    sql += `${ rowsForPage },`;
    sql += `'${ qName }',`;
    sql += `${ showInactive } );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        let sqlOverall = `CALL ts_sp_overallPageJournalDriverWeb(`;
        sqlOverall += `'${ qName }',`;
        sqlOverall += `${ showInactive } );`;
        MysqlCon.onExecuteQuery(sqlOverall, (errorOverall: any, dataOverall: any[]) => {

            if (errorOverall) {
                return res.status(400).json({
                    ok: false,
                    error: errorOverall
                });
            }
        
            res.json({
                ok: true,
                total: dataOverall[0].total,
                data
            });
        });
    
    });

});

LiquRouter.get('/Account/Driver/:pk', [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    
    let pkDriverToken = req.params.pk || 0;
    let sql = `CALL ts_sp_getAccountDriver( ${ pkDriverToken } );`;

    // console.log( sql );

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            data
        });

    });
    
});

LiquRouter.get('/Services/Journal', [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    
    let page = req.query.page || 1;
    let pkDriver = req.query.pkDriver || 0;
    let fkJournal = req.query.fkJournal || 0;
    let codeJournal = req.query.codeJournal || 0;

    // IN `InPage` tinyint,
    // IN `InPkUserDriver` int,
    // IN `InFkJournal` bigint,
    // IN `InCodeJournal` varchar(10)

    let sql = `CALL ts_sp_getServicesJournal( `;
    sql += `${ page },`;
    sql += `${ pkDriver },`;
    sql += `${ fkJournal },`;
    sql += `'${ codeJournal }'`;
    sql += `);`;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        let sqlOverall = `CALL ts_sp_overallPageServicesJournal(`;
        sqlOverall += `${ pkDriver },`;
        sqlOverall += `${ fkJournal },`;
        sqlOverall += `'${ codeJournal }'`;
        sqlOverall += `);`;
        
        MysqlCon.onExecuteQuery(sqlOverall, (errorOverall: any, dataOverall: any[]) => {

            if (errorOverall) {
                return res.status(400).json({
                    ok: false,
                    error: errorOverall
                });
            }
        
            res.json({
                ok: true,
                total: dataOverall[0].total,
                data
            });
        });

    });
    
});


export default LiquRouter;

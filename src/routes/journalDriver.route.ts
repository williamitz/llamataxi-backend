import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { verifyDriverRole } from '../middlewares/token.mdd';
import moment from 'moment';

let JDriverRouter = Router();
let MysqlCon = MysqlClass.instance;

JDriverRouter.get('/ConfigJournal', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    // let pkUserToken = req.userData.pkUser || 0;
        
    let sql = `CALL ts_sp_getListAllCJournal( );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
    
        res.json({
            ok: true,
            data
        });
    });

});

JDriverRouter.post('/JournalDriver', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let body = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkDriverToken = req.userData.pkDriver || 0;
        
    let sql = `CALL ts_sp_addJournalDriver( `;
    sql += `${ body.fkConfigJournal || 0 }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

    console.log(sql);
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
    
        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });
    });

});

JDriverRouter.get('/JournalDriver', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let status = req.query.status || true;
    let pkDriverToken = req.userData.pkDriver || 0;
        
    let sql = `CALL ts_sp_getListJournalDriver( `;
    sql += `${ status }, `;
    sql += `${ pkDriverToken } );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data.length > 0) {
            data.forEach( (journal) => {
                const dateStart = moment( journal.dateStart );
                const current = moment();
                journal.expired = current.diff( dateStart, 'hours' ) > 23 ? true : false;
                journal.dateExpired = dateStart.add( 24, 'hours' );
            });
        }
    
        res.json({
            ok: true,
            data
        });
    });

});

JDriverRouter.put('/JournalDriver/:pk', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let pkJournal = req.params.pk || 0;
    let pkUserToken = req.userData.pkUser || 0;
    let pkDriverToken = req.userData.pkDriver || 0;
        
    let sql = `CALL ts_sp_closeJournal( `;
    sql += `${ pkJournal }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
    
        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });
    });

});

export default JDriverRouter;


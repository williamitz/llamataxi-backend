import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { verifyDriverRole } from '../middlewares/token.mdd';
import moment from 'moment';
import IBodyJournal from "../interfaces/body_journalDriver.interface";
import MainServer from "../classes/mainServer.class";

moment.locale('es');

let JDriverRouter = Router();
let MysqlCon = MysqlClass.instance;
let Server = MainServer.instance;

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
    let body: IBodyJournal = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkDriverToken = req.userData.pkDriver || 0;
        
    let sql = `CALL ts_sp_addJournalDriver( `;
    sql += `${ body.fkConfJournal || 0 }, `;
    sql += `${ pkDriverToken }, `;
    
    sql += `'${ body.cardCulqui }', `;
    sql += `${ body.chargeAmount }, `;

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
    let pkUserToken = req.userData.pkUser || 0;
        
    let sql = `CALL ts_sp_getListJournalDriver( `;
    sql += `${ status }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ pkUserToken } );`;

    // console.log('sql journal driver', sql);
    
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

                // console.log('f. inicio', dateStart.format('yyyy/MM/DD') );
                
                if (journal.modeJournal != 'FORTODAY' ) {
                    const dateExp = moment( dateStart ).set( 'hour', 23 ).set('minutes', 59);
                    // console.log('f. exp', dateExp );
                    journal.dateExpired = dateExp;
                    journal.expired = dateExp.diff( current, 'minutes' ) > 0 ? false : true;;
                } else {
                    journal.dateExpired = dateStart.add( 24, 'hours' );
                    journal.expired = current.diff( dateStart, 'hours' ) > 23 ? true : false;
                }
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
    let nameDriver = req.userData.nameComplete || '';

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

        if (data[0].showError === 0) {
            Server.io.in('WEB').emit('close-journal', { nameDriver, pkJournal });
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });
    });

});

export default JDriverRouter;


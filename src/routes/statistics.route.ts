import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import { verifyDriverRole } from '../middlewares/token.mdd';
import moment from 'moment';
import { ChallengeContext } from "twilio/lib/rest/verify/v2/service/entity/challenge";

moment.locale('ES');

let StatRouter = Router();

let MysqlCon = MysqlClass.instance;

StatRouter.get('/Statistics/Week', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let weekStart = moment().startOf('week');
    let weekEnd = moment().endOf('week');

    // weekStart = weekStart.add(1, 'day');
    // weekEnd = weekEnd.add(1, 'day');

    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL ts_sp_getStatisticsWeek(`;
    sql += `${ fkUser }, `;
    sql += ` '${ weekStart.format('YYYY-MM-DD') }', `;
    sql += ` '${ weekEnd.format('YYYY-MM-DD') }' );`;

    console.log(sql);

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        let total = 1;
        if ( data.length === 0 ) {
            total = 0;
            data = [
                { day: 'Lun', totalFinaliced: 0 },
                { day: 'Mar', totalFinaliced: 0 },
                { day: 'Mie', totalFinaliced: 0 },
                { day: 'Jue', totalFinaliced: 0 },
                { day: 'Vie', totalFinaliced: 0 },
                { day: 'Sab', totalFinaliced: 0 },
                { day: 'Dom', totalFinaliced: 0 },
            ];
        } else {
            data.forEach( (rec: any) => {
                let nameDay = moment( rec.day ).format('ddd');
                nameDay = nameDay.substr( 0, nameDay.length -1 ) ;

                nameDay = nameDay[0].toUpperCase() + nameDay.substr( 1, nameDay.length ) ;
                rec.day = nameDay;
            });
        }
        
        res.json({
            ok: true,
            total,
            data
        });

    });
});

StatRouter.get('/Statistics/Day', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let weekStart = moment();
    // let weekStart = moment().add(1, 'day');
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL ts_sp_getStatisticsDay(`;
    sql += `${ fkUser }, `;
    sql += ` '${ weekStart.format('YYYY-MM-DD') }' );`;

    console.log(sql);

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        
        
        res.json({
            ok: true,
            data: data[0]
        });

    });
});

export default StatRouter;

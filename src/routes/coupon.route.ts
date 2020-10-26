import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyWebRoles, verifyWebmasterRole, verifyToken } from '../middlewares/token.mdd';
import reqIp from "request-ip";
import { IconfigRef } from '../interfaces/body_configRef.interface';
import { ICoupon } from "../interfaces/body_coupon.interface";

let CouponRouter = Router();

let MysqlCon = MysqlClass.instance;

CouponRouter.get('/Coupon', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {

    let page = req.query.page || 1;
    let showInactive = req.query.showInactive || true;
    let qTitle = req.query.qTitle || '';
    let qLte = req.query.qLte || 0;
    let qGte = req.query.qGte || 0;
    let qEq = req.query.qEq || 0;
    
    /**
     *  IN `InPage` int,
        IN `InRowsForPage` tinyint,
        IN `InQuery` varchar(50),
        IN `InLte` float(4,2),
        IN `InGte` float(4,2),
        IN `InEq` float(4,2),
        IN `InStatus` tinyint
     */
    
    let sql = `CALL rb_sp_getListCoupon(`;
    sql += `${ page }, `;
    sql += `10, `;
    sql += `'${ qTitle }', `;
    sql += `${ qLte }, `;
    sql += `${ qGte }, `;
    sql += `${ qEq }, `;
    sql += `${ showInactive } );`;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        let sqlOverall = `CALL rb_sp_overallPageCoupon( `;
        sqlOverall += `'${ qTitle }', `;
        sqlOverall += `${ qLte }, `;
        sqlOverall += `${ qGte }, `;
        sqlOverall += `${ qEq }, `;
        sqlOverall += `${ showInactive } );`;

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

CouponRouter.post('/Coupon/Add', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let body: ICoupon = req.body;
    let pkUserToken = req.userData.pkUser || 0;

    /**
     * IN `InCode` char(6),
        IN `InTitle` varchar(40),
        IN `InDescription` varchar(100),
        IN `InMinRate` float(5,2),
        IN `InAmount` float(5,2),
        IN `InDateExpiration` varchar(12),
        IN `InDaysExpiration` tinyint,
        IN `InFkUser` int,
        IN `InIpUser` varchar(20) )
     */

    let sql = `CALL rb_sp_addCoupon(`;
    sql += `'${ body.codeCoupon }', `;
    sql += `'${ body.title }', `;
    sql += `'${ body.description }', `;
    sql += `${ body.minRateService }, `;
    sql += `${ body.amountCoupon }, `;
    sql += `'${ body.dateExpiration }', `;
    sql += `${ body.daysExpiration }, `;
    sql += `'${ body.role }', `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }');`;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

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

export default CouponRouter;
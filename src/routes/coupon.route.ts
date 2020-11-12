import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyWebmasterRole, verifyToken, verifyDriverClientRole } from '../middlewares/token.mdd';
import reqIp from "request-ip";
import { ICoupon } from "../interfaces/body_coupon.interface";

let CouponRouter = Router();

let MysqlCon = MysqlClass.instance;

CouponRouter.get('/Coupon', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {

    let page = req.query.page || 1;
    let showInactive = req.query.showInactive || true;
    let qCode = req.query.qCode || '';
    let qTitle = req.query.qTitle || '';
    let qRole = req.query.qRole || 'ALL';

    let qLte = req.query.qLte || 0;
    let qGte = req.query.qGte || 0;
    let qEq = req.query.qEq || 0;

    let rolesValid = ['CLIENT', 'DRIVER', 'ALL'];
    if (!rolesValid.includes( qRole ) ) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Roles válidos ' + rolesValid.join(', ')
            }
        });
    }
    
    let sql = `CALL rb_sp_getListCoupon(`;
    sql += `${ page }, `;
    sql += `10, `;
    sql += `'${ qCode }', `;
    sql += `'${ qTitle }', `;
    sql += `'${ qRole }', `;
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
        sqlOverall += `'${ qCode }', `;
        sqlOverall += `'${ qTitle }', `;
        sqlOverall += `'${ qRole }', `;
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
    let rolesValid = ['CLIENT_ROLE', 'DRIVER_ROLE'];

    if (!rolesValid.includes( body.roleCoupon )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles válidos son ' + rolesValid.join(', ')
            }
        });
    }

    let sql = `CALL rb_sp_addCoupon(`;
    sql += `'${ body.codeCoupon.toUpperCase() }', `;
    sql += `'${ body.titleCoupon }', `;
    sql += `'${ body.descriptionCoupon }', `;
    sql += `${ body.minRateService }, `;
    sql += `${ body.amountCoupon }, `;
    sql += `'${ body.dateExpiration }', `;
    sql += `${ body.daysExpiration }, `;
    sql += `'${ body.roleCoupon }', `;
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

CouponRouter.put('/Coupon/:pk', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let body: ICoupon = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkCoupon = req.params.pk || 0;

    let rolesValid = ['CLIENT_ROLE', 'DRIVER_ROLE'];

    if (!rolesValid.includes( body.roleCoupon )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles válidos son ' + rolesValid.join(', ')
            }
        });
    }

    let sql = `CALL rb_sp_updateCoupon(`;
    sql += `${ pkCoupon }, `;
    sql += `'${ body.codeCoupon.toUpperCase() }', `;
    sql += `'${ body.titleCoupon }', `;
    sql += `'${ body.descriptionCoupon }', `;
    sql += `${ body.amountCoupon }, `;
    sql += `'${ body.dateExpiration }', `;
    sql += `${ body.daysExpiration }, `;
    sql += `${ body.minRateService }, `;
    sql += `'${ body.roleCoupon }', `;
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

CouponRouter.delete('/Coupon/:pk/:code/:status', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let pkUserToken = req.userData.pkUser || 0;
    let pkCoupon = req.params.pk || 0;
    let codeCoupon = req.params.code || 'xD';
    let status = req.params.status || 'true';

    let statusValid = ['true', 'false'];

    if (!statusValid.includes( status )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Estado inválido'
            }
        });
    }

    let sql = `CALL rb_sp_deleteCoupon(`;
    sql += `${ pkCoupon }, `;
    sql += `'${ codeCoupon.toUpperCase() }', `;
    sql += `${ status }, `;
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

// apis para asociar un cupon (solo clientes y conductores)

CouponRouter.put('/Coupon/Valid/:code', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let codeCoupon = req.params.code || 0;
    
    let sql = `CALL rb_sp_addCouponUser(`;
    sql += `'${ codeCoupon.toUpperCase() }', `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }');`;

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
            showError: data[0].showError,
            data: data[0]
        });

    });

});

CouponRouter.get( '/Coupon/User', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    
    let status = req.query.status || 'OK';
    let pkUserToken = req.userData.pkUser || 0;

    let statusValid = ['OK', 'USED', 'EXPIRED'];

    if (!statusValid.includes( status )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles válidos son ' + statusValid.join(', ')
            }
        });
    }

    let sql = `CALL rb_sp_getCouponUser(`;
    sql += `${ pkUserToken }, `;
    sql += `'${ status }' );`;

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

// apis para puntos y referidos

CouponRouter.get('/Referal', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    
    let page = req.query.page || 1;
    let status = req.query.status || 'OK';
    let pkUserToken = req.userData.pkUser || 0;

    let statusValid = ['OK', 'USED', 'EXPIRED'];

    if (!statusValid.includes( status )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles válidos son ' + statusValid.join(', ')
            }
        });
    }

    let sql = `CALL rb_sp_getReferalUser(`;
    sql += `${ page }, `;
    sql += `'${ status }', `;
    sql += `${ pkUserToken } ); `;

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

CouponRouter.get('/Referal/Total', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {

    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL rb_sp_getTotalReferal( ${ pkUserToken } ); `;

    MysqlCon.onExecuteQuery( sql, ( error: any, data: any[] ) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }
        
        res.json({
            ok: true,
            total: data[0].total
        });

    });

});

export default CouponRouter;
import { Router, Request, Response } from 'express';
import { verifyToken, verifyWebmasterRole } from '../middlewares/token.mdd';
import MysqlClass from '../classes/mysqlConnect.class';
import reqIp from 'request-ip';

let DriverRoutes = Router();

let MysqlCss = MysqlClass.instance;

DriverRoutes.put('/Driver/Profile/:id', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {
    
    let pkDriver = req.params.id || 0;

    let sql = `CALL as_sp_getProfileDriver( ${ pkDriver } );`
    
    MysqlCss.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        let sqlVehicles = `CALL as_sp_getVehicleDriver( ${ pkDriver } );`;

        MysqlCss.onExecuteQuery( sqlVehicles, (errorVehicle: any, dataVehicle: any[]) => {
            if (errorVehicle) {
                return res.status(400).json({
                    ok: false,
                    error: errorVehicle,
                });
            }

            res.json({
                ok: true,
                data: { profile: data[0], vehicles: dataVehicle }
            });
        });
    });

});

DriverRoutes.get('/Driver/Vehicle/Get/:id', [verifyToken], (req: Request, res: Response) => {
    
    let pkDriver = req.params.id || 0;

    let sqlVehicles = `CALL as_sp_getVehicleDriver( ${ pkDriver } );`;

    MysqlCss.onExecuteQuery( sqlVehicles, (error: any, data: any[]) => {
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

DriverRoutes.put('/Vehicle/Verify/:driver/:vehicle', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {

    let body = req.body;
    let pkDriver = req.params.driver;
    let pkVehicle = req.params.vehicle;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateVerifyVehicle(${ pkVehicle }, ${ pkDriver }, ${ body.fkCategory }, ${ body.fkBrand }, ${ body.fkModel }, '${ body.observation }', '${ body.numberPlate }', ${ fkUser }, '${ reqIp.getClientIp( req ) }');`;

    MysqlCss.onExecuteQuery( sql, (error: any, data: any[]) => {
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

DriverRoutes.put( '/Driver/verify/:driver', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let body = req.body;
    let pkDriver = req.params.driver;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateVerifDriver( ${ pkDriver }, '${ body.observation }', ${ fkUser }, '${ reqIp.getClientIp( req ) }');`;

    MysqlCss.onExecuteQuery( sql, (error: any, data: any[]) => {
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

export default DriverRoutes;
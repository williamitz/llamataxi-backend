import { Router, Request, Response } from 'express';
import { verifyToken, verifyWebmasterRole } from '../middlewares/token.mdd';
import MysqlClass from '../classes/mysqlConnect.class';

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
                data: [{ profile: data[0], vehicles: dataVehicle }]
            });
        });
    });

});

export default DriverRoutes;
import { Router, Request, Response } from 'express';
import { verifyToken, verifyWebmasterRole, verifyWebRoles } from '../middlewares/token.mdd';
import MysqlClass from '../classes/mysqlConnect.class';
import reqIp from 'request-ip';
import { IBodyUser } from '../interfaces/body_user.interface';
import MainServer from '../classes/mainServer.class';
import h3 from 'h3-js';

let DriverRoutes = Router();

let Server = MainServer.instance;
let MysqlCnn = MysqlClass.instance;

DriverRoutes.put('/Driver/Profile/:id', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {
    
    let pkDriver = req.params.id || 0;

    let sql = `CALL as_sp_getProfileDriver( ${ pkDriver } );`
    
    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error,
            });
        }

        let sqlVehicles = `CALL as_sp_getVehicleDriver( ${ pkDriver } );`;

        MysqlCnn.onExecuteQuery( sqlVehicles, (errorVehicle: any, dataVehicle: any[]) => {
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

    MysqlCnn.onExecuteQuery( sqlVehicles, (error: any, data: any[]) => {
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

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            Server.io.in( 'WEB' ).emit( 'current-new-verfified', {pkservice: data[0].pkService} )
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });
});

DriverRoutes.put('/Driver/Profile/Update/:id', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let pkDriver = req.params.id || 0;
    let body: IBodyUser = req.body;
    let fkUser = req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateProfileDriver(`;
    sql += `${ body.pkUser }, `;
    sql += `${ body.pkPerson }, `;
    sql += `${ pkDriver }, `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.document }', `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.sex }', `;
    sql += `'${ !body.birthDate ? '' : body.birthDate }', `;
    sql += `'${ body.dateLicenseExpiration }', `;
    sql += `${ body.isEmployee }, `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' `;
    sql += `);`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok:true,
            showError: data[0].showError,
            data: data[0]
        });

    });

});

DriverRoutes.delete('/Driver/:pkUser/:pkDriver/:status', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {

    let pkUser = req.params.pkUser || 0;
    let pkDriver = req.params.pkDriver || 0;
    let status = req.params.status;
    let observation = req.query.obs || '';
    let fkUser = req.userData.pkUser || 0;
    
    let statusValid = ['true', 'false'];

    if (!statusValid.includes( status )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los estados válidos son ' + statusValid.join(', ')
            }
        });
    }
    
    let sql = `CALL as_sp_deleteDriver(`;
    sql += `${ pkUser }, `;
    sql += `${ pkDriver }, `;
    sql += `${ status }, `;
    sql += `'${ observation }', `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }');`;    
    
    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

DriverRoutes.get('/Monitor/Drivers', [verifyToken], (req: any, res: Response) => {
    
    let sql = 'CALL as_sp_getMonitorDrivers();'

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

DriverRoutes.get('/Monitor/Clients', [verifyToken], (req: any, res: Response) => {
    
    let sql = 'CALL as_sp_getMonitorClients();'

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

DriverRoutes.get('/Monitor/GetZones', [verifyToken, verifyWebRoles], (req: any, res: Response) => {
    
    let sql =  `CALL as_sp_getZonesDemand( );`;

    // console.log('sql zonas calientes', sql);
    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        let dataString = JSON.stringify(data);
        let json: any[] = JSON.parse(dataString);

        if (json.length) {
            
            json.forEach( zone => {
                // extraemos las coordenadas de los vértices del polígono
                zone.polygon = h3.h3ToGeoBoundary( zone.indexHex, false );
                // extraemos las coordenadas del centro del polígono
                zone.center = h3.h3ToGeo( zone.indexHex );
            });

        }

        res.json({
            ok: true,
            data: json
        });

    });

});

export default DriverRoutes;
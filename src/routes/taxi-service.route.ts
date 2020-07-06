import { Request, Response, Router } from "express";
import { verifyToken, verifyClientRole, verifyDriverRole, verifyDriverClientRole } from '../middlewares/token.mdd';
import MainServer from '../classes/mainServer.class';
import MysqlClass from '../classes/mysqlConnect.class';
import { IBodyService, IBodyOffer } from '../interfaces/body_service.interface';
import reqIp from 'request-ip';
import h3 from "h3-js";
import { ListUserSockets } from '../classes/listUserSockets.class';
import { UserSocket } from '../classes/userSocket.class';

let TServiceRouter = Router();

let Server = MainServer.instance;
let Users = ListUserSockets.instance;
let MysqlCon = MysqlClass.instance;

TServiceRouter.get('/Journal/GetForHour', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    // console.log(data);
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecificó las jornadas de tarifa'
            }
        });
    }

    res.json({
        ok: true,
        data
    });
                  
});

TServiceRouter.get('/Rate/GetForJournal', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecificó las jornadas de tarifa'
            }
        });
    }

    let sql = `CALL ts_sp_getRateForJournal(${ data.pkJournal });`;
    // console.log('sql tarifa ', sql);
    MysqlCon.onExecuteQuery(sql, (error: any, dataRate: any[]) => {

        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }

        res.json({
            ok: true,
            data: [{ dataRate }],
        });
    
      });
                  
});

TServiceRouter.post('/Service/Add', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    let body: IBodyService = req.body;
    let fkUser = req.userData.pkUser || 0;
    
    let indexHex = h3.geoToH3( body.coordsOrigin.lat, body.coordsOrigin.lng, Server.radiusPentagon );

    let sql = `CALL ts_sp_addService( `
    sql += `${ body.fkJournal }, `;
    sql += `${ body.fkRate }, `;
    sql += `${ body.fkCategory }, `;
    sql += `${ fkUser }, `;
    sql += `${ body.coordsOrigin.lat }, `;
    sql += `${ body.coordsOrigin.lng }, `;
    sql += `'${ body.streetOrigin }', `;
    sql += `${ body.coordsDestination.lat }, `;
    sql += `${ body.coordsDestination.lng }, `;
    sql += `'${ body.streetDestination }', `;
    sql += `${ body.distance }, `;
    sql += `'${ body.distanceText }', `;
    sql += `${ body.minutes }, `;
    sql += `'${ body.minutesText }', `;

    sql += `${ body.rateHistory }, `;
    sql += `${ body.rateService }, `;
    sql += `${ body.minRatePrc }, `;
    sql += `${ body.isMinRate }, `;
    
    sql += `'${ body.paymentType }', `;
    sql += `'${ indexHex }', `;

    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        // enviar notificación a conductores cercanos
        const drivers: UserSocket[] =  Users.onGetDriverHex(indexHex);

        if (drivers.length > 0) {
            drivers.forEach( driver => {
                Server.io.to( driver.id ).emit('new-service', {data: data[0]});
            });
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });
});

TServiceRouter.get('/Culqui/Key', [verifyToken], (req: any, res: Response) => {
    
    let sql = `CALL cc_sp_getCulquiKey();`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: true,
                error
            });
        }

        res.json({
            ok: true,
            data: data[0]
        });
    });
});

TServiceRouter.get('/PercentRate', [verifyToken], (req: Request, res: Response) => {
    
    res.json({
        ok: true,
        data: [{percentRate: Server.getPercentRate()}]
    });

});

TServiceRouter.get('/Services/Driver', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {
    
    let page = req.query.page || 1;
    let fkUser = req.userData.pkUser || 0;

    let sql =  `CALL ts_sp_getServicesForDriver( ${ page }, ${ fkUser } );`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        let sqlOverall =  `CALL ts_sp_overallPageServicesForDriver( ${ fkUser } );`;

        MysqlCon.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[]) => {

            if (errorOverall) {
                return res.status(400).json({
                    ok: false,
                    error: errorOverall
                });
            }
    
            res.json({
                ok: true,
                data,
                total: dataOverall[0].total
            });
    
        });

        
    });

});

TServiceRouter.get('/Services/Driver/Total', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {

    let fkUser = req.userData.pkUser || 0;

    let sql =  `CALL ts_sp_overallPageServicesForDriver( ${ fkUser });`;
    
    console.log('total services', sql);

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok: true,
            total: data[0].total
        });

    });
});

TServiceRouter.get('/Demand', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let fkUser = req.userData.pkUser || 0;
    // mostrarle al conductor la demanda que existe en su poligono padre
    
    /**
     * IN `InPkUser` int,
        IN `InChildrenOne` varchar(20),
        IN `InChildrenTwo` varchar(20),
        IN `InChildrenThree` varchar(20),
        IN `InChildrenFour` varchar(20),
        IN `InChildrenFive` varchar(20),
        IN `InChildrenSix` varchar(20),
        IN `InChildrenSevent` varchar(20)
     */
    const userSk: UserSocket = Users.onFindUserForPk( fkUser );

    // obtener el padre de la ubicación dada en un radio mas grande
    // const indexParent = h3.h3ToParent( userSk.indexHex , 9);
    // console.log(`indice padre ${ indexParent }`);
    // extraer los indices hijos de un pentágono con radio 6 del indice padre
    const indexChildren: string[] = h3.kRing( userSk.indexHex , 1);
    // console.log(`indice hijos ${ indexChildren }`);

    let sql =  `CALL ts_sp_getZonesDemand( ${ fkUser }, `;
    sql += `'${ indexChildren[0] || '' }', `;
    sql += `'${ indexChildren[1] || '' }', `;
    sql += `'${ indexChildren[2] || '' }', `;
    sql += `'${ indexChildren[3] || '' }', `;
    sql += `'${ indexChildren[4] || '' }', `;
    sql += `'${ indexChildren[5] || '' }', `;
    sql += `'${ indexChildren[6] || '' }'`;
    sql += ` );`;

    // console.log(  sql);

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        let dataString = JSON.stringify(data);
        let json: any[] = JSON.parse(dataString);

        if (json.length) {

            /**
             * indexHex, COUNT(*) AS 'total'
             */

            
            json.forEach( service => {
                console.log('es un indice válido', h3.h3IsValid( service.indexHex ));
                // service.polygon = geojson2h3.h3ToFeature( service.indexHex, {} ).geometry;
                service.polygon = h3.h3ToGeoBoundary( service.indexHex, false );
                service.center = h3.h3ToGeo( service.indexHex );
            });

        }

        res.json({
            ok: true,
            data: json
        });

    });
    
});

TServiceRouter.post('/Service/NewOffer', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let fkUser = req.userData.pkUser || 0;
    let body: IBodyOffer = req.body;

    /**IN `InPkService` int,
    IN `InPkOffer` int,
    IN `InRateOffer` float(10,2),
    IN `InIsClient` tinyint,
    IN `InFkDriver` INT -- pkuser**/
    /**
     * fkDriver: 2
        isClient: true
        pkOffer: 1
        pkService: 2
        rateOffer: 4.16
     */

    let sql = `CALL ts_sp_addOfferService(`;
    sql += `${ body.pkService },`;
    sql += `${ body.pkOffer }, `;
    sql += `${ body.rateOffer }, `;
    sql += `${ body.isClient }, `;
    sql += `${ body.fkDriver }, `;
    sql += `${ body.fkVehicle }`;
    sql += `);`;
    
    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

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


TServiceRouter.get('/Offer/Client', [verifyToken], (req: any, res: Response) => {
    let page = req.query.page || 0;
    let fkUser = req.userData.pkUser || 0;
    let sql = `CALL ts_sp_getServicesForClient(${ page }, ${ fkUser });`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        
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

TServiceRouter.get('/Offer/Client/Total', [verifyToken], (req: any, res: Response) => {
    let fkUser = req.userData.pkUser || 0;
    let sql = `CALL ts_sp_overallPageServicesforClient(${ fkUser });`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
        
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok: true,
            total: data[0].total
        });

    });

});

TServiceRouter.post('/Offer/Accepted/Client', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    
    let fkUser = req.userData.pkUser || 0;
    let body: IBodyOffer = req.body;

    /**IN `InPkService` bigint,
        IN `InFkOffer` bigint,
        IN `InFkDriver` int, #pkuser del conductor
        IN `InRate` float(10,2),
        IN `InFkUser` int,**/

    let sql = `CALL ts_sp_acceptOfferClient(`;
    sql += `${ body.pkService },`;
    sql += `${ body.pkOffer }, `;
    sql += `${ body.fkDriver }, `;
    sql += `${ body.rateOffer }, `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;
    
    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

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

TServiceRouter.put('/Service/Info/:pk', [verifyToken, verifyDriverClientRole], (req: Request, res: Response) => {
    let pkService = req.params.pk || 0;

    let sql = `CALL ts_sp_getInfoService( ${ pkService } );`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        res.json({
            ok: true,
            data: data[0]
        });

    }); 
});


export default TServiceRouter;
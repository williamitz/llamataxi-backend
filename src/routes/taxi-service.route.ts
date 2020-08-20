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
    sql += `${ body.minRate }, `;
    sql += `${ body.minRatePercent }, `;
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
        // const drivers: UserSocket[] =  Users.onGetDriverHex(indexHex);

        // if (drivers.length > 0) {
        //     drivers.forEach( driver => {
        //         Server.io.to( driver.id ).emit('new-service', {data: data[0]});
        //     });
        // }

        if (data[0].showError === 0) {
            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            Server.io.in( 'WEB' ).emit( 'current-new-service', {pkservice: data[0].pkService} )
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

    const userSk: UserSocket = Users.onFindUserForPk( fkUser );

    /**
     * Obtenga todos los hexágonos en un anillo k alrededor de un centro dado. 
     * El orden de los hexágonos no está definido.
     */
    // const indexChildren: string[] = h3.kRing( userSk.indexHex , 1);

    // obtener el padre de la ubicación dada en un radio mas grande
    const indexParent = h3.h3ToParent( userSk.indexHex , Server.radiusPather);

    // extraer los indices hijos de un pentágono con radio 6 del indice padre
    const indexChildren: string[] = h3.h3ToChildren( indexParent , Server.radiusPentagon);


    const InWhereIndex = `( '${ indexChildren.join("', '") }' )`;
    let sql =  `CALL ts_sp_getZonesDemand( ${ fkUser }, `;
    // sql += `'${ indexChildren[0] || '' }', `;
    // sql += `'${ indexChildren[1] || '' }', `;
    // sql += `'${ indexChildren[2] || '' }', `;
    // sql += `'${ indexChildren[3] || '' }', `;
    // sql += `'${ indexChildren[4] || '' }', `;
    // sql += `'${ indexChildren[5] || '' }', `;
    // sql += `'${ indexChildren[6] || '' }'`;
    sql += ` "${ InWhereIndex }");`;

    console.log('sql zonas calientes', sql);
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
            
            json.forEach( service => {
                // extraemos las coordenadas de los vértices del polígono
                service.polygon = h3.h3ToGeoBoundary( service.indexHex, false );
                // extraemos las coordenadas del centro del polígono
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
    let nameUser = req.userData.nameComplete || '';

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

        if (data[0].showError === 0) {
            const indexParent = h3.h3ToParent( body.indexHex , Server.radiusPather);
            
            // extraer los indices hijos de un pentágono con radio 6 del indice padre
            const indexChildren: string[] = h3.h3ToChildren( indexParent , Server.radiusPentagon);
            const msg = `${ nameUser }, ha aceptado a otro conductor.`;
            // Server.io.in( body.indexHex ).emit( 'client-cancel-service', { pkService, msg } );
            indexChildren.forEach( indexHex => {
                Server.io.in( indexHex ).emit( 'disposal-service', { pkService: body.pkService, msg, indexHex: body.indexHex } );
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

TServiceRouter.put('/Service/Delete/:id', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    
    let fkUser = req.userData.pkUser || 0;
    let nameUser = req.userData.nameComplete || '';
    let pkService = req.params.id || 0;

    let body = req.body;

    let sql = `CALL ts_sp_deleteService( ${ pkService }, ${ fkUser }, '${ reqIp.getClientIp( req ) }' );`;
    
    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            // obtener el padre de la ubicación dada en un radio mas grande
            const indexParent = h3.h3ToParent( body.indexHex , Server.radiusPather);
            
            // extraer los indices hijos de un pentágono con radio 6 del indice padre
            const indexChildren: string[] = h3.h3ToChildren( indexParent , Server.radiusPentagon);
            const msg = `${ nameUser }, ha cancelado el servicio.`;
            // Server.io.in( body.indexHex ).emit( 'client-cancel-service', { pkService, msg } );
            indexChildren.forEach( indexHex => {
                Server.io.in( indexHex ).emit( 'disposal-service', { pkService, msg, indexHex: body.indexHex } );
            });

            // notificar al panel que se eliminó un servicio
            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            Server.io.in( 'WEB' ).emit( 'current-del-service', {} );
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    }); 

});

TServiceRouter.put('/Service/DeleteRun/:id/:isClient', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let pkService = req.params.id || 0;
    let isClient = req.params.isClient || null;
    let fkUser = req.userData.pkUser || 0;

    let validIs = ['true', 'false'];

    if (!validIs.includes( isClient )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Es cliente inválido'
            }
        });
    }

    let sql = `CALL ts_sp_deleteServiceRun(`;
    sql += `${ pkService },`;
    sql += `${ isClient },`;
    sql += `${ fkUser },`;
    sql += `'${ reqIp.getClientIp(req) }'`;
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

TServiceRouter.post('/Offer/Decline', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    let fkUser = req.userData.pkUser || 0;
    let body = req.body;

    let sql = `CALL ts_sp_declineOfferDriver(`;
    sql += `${ body.pkOffer }, `;
    sql += `${ body.pkService }, `;
    sql += `${ fkUser }, `;
    sql += `0`;
    sql += `);`

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

TServiceRouter.post('/Offer/Decline/Client', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    // let fkUser = req.userData.pkUser || 0;
    let body = req.body;

    let sql = `CALL ts_sp_declineOfferDriver(`;
    sql += `${ body.pkOffer }, `;
    sql += `${ body.pkService }, `;
    sql += `${ body.pkDriver }, `;
    sql += `1`;
    sql += `);`

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

TServiceRouter.put('/Service/Calification/:id', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    
    let body = req.body;
    let fkUser = req.userData.pkUser || 0;
    let pkService = req.params.id || 0;
    /**
     IN `InFkservice` bigint,
    IN `InIsClient` tinyint,
    IN `InCalification` tinyint,
    IN `InObservation` varchar(255),
    IN `InFkUser` int,
    IN `InIp` varchar(20)
     */

    let sql = `CALL ts_sp_addCalification(`;
    sql += `${ pkService }, `;
    sql += `${ body.isClient }, `;
    sql += `${ body.calification }, `;
    sql += `'${ body.observation }', `;
    sql += `${ fkUser },`;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`

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


export default TServiceRouter;
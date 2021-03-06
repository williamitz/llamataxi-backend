import { Request, Response, Router } from "express";
import { verifyToken, verifyClientRole, verifyDriverRole, verifyDriverClientRole, verifyTokenMonitor } from '../middlewares/token.mdd';
import MainServer from '../classes/mainServer.class';
import MysqlClass from '../classes/mysqlConnect.class';
import { IBodyService, IBodyOffer } from '../interfaces/body_service.interface';
import reqIp from 'request-ip';
import h3 from "h3-js";
import { ListUserSockets } from '../classes/listUserSockets.class';
import { UserSocket } from '../classes/userSocket.class';
import jwt from 'jsonwebtoken';
import { SEED_KEY } from "../global/environments.global";

let TaxiRouter = Router();

let Server = MainServer.instance;
let Users = ListUserSockets.instance;
let MysqlCon = MysqlClass.instance;

TaxiRouter.get('/Journal/GetForHour', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecific√≥ las jornadas de tarifa'
            }
        });
    }

    res.json({
        ok: true,
        data
    });
                  
});

TaxiRouter.get('/Rate/GetForJournal', [verifyToken], (req: Request, res: Response) => {
    
    const dataJournal = Server.getJournal();
    if (dataJournal.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecific√≥ las jornadas de tarifa'
            }
        });
    }

    let sql = `CALL ts_sp_getRateForJournal(${ dataJournal.pkJournal });`;
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {

        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }

        res.json({
            ok: true,
            data,
        });
    
    });
                  
});

TaxiRouter.post('/Service/Add', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    let body: IBodyService = req.body;
    let fkUser = req.userData.pkUser || 0;
    let discountValid = ['NONEDD', 'COUPON', 'CREDIT'];

    if ( !discountValid.includes( body.discountType ) ) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los descuentos v√°lidos son ' + discountValid.join(', ')
            }
        });
    }
    
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

    // pago con tarjeta
    sql += `'${ body.cardTkn }', `;
    sql += `'${ body.chargeCulqui }', `;
    sql += `'${ body.cardCulqui }', `;

    // descuentos
    sql += `${ body.fkCouponUser }, `;
    sql += `${ body.discount }, `;
    sql += `'${ body.discountType }', `;

    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

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

// TaxiRouter.get('/Culqui/Key', [verifyToken], (req: any, res: Response) => {
    
//     let sql = `CALL cc_sp_getCulquiKey();`;

//     MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
//         if (error) {
//             return res.status(400).json({
//                 ok: true,
//                 error
//             });
//         }

//         res.json({
//             ok: true,
//             data: data[0]
//         });
//     });
// });

TaxiRouter.get('/PercentRate', [verifyToken], (req: Request, res: Response) => {
    
    res.json({
        ok: true,
        data: [{percentRate: Server.getPercentRate()}]
    });

});

TaxiRouter.get('/Services/Driver', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {
    
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

TaxiRouter.get('/Services/Driver/Total', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {

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

TaxiRouter.get('/Demand', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let fkUser = req.userData.pkUser || 0;
    // mostrarle al conductor la demanda que existe en su poligono padre

    const userSk: UserSocket = Users.onFindUserForPk( fkUser );

    /**
     * Obtenga todos los hex√°gonos en un anillo k alrededor de un centro dado. 
     * El orden de los hex√°gonos no est√° definido.
     */
    // const indexChildren: string[] = h3.kRing( userSk.indexHex , 1);

    // obtener el padre de la ubicaci√≥n dada en un radio mas grande
    const indexParent = h3.h3ToParent( userSk.indexHex , Server.radiusPather);

    // extraer los indices hijos de un pent√°gono con radio 6 del indice padre
    const indexChildren: string[] = h3.h3ToChildren( indexParent , Server.radiusPentagon);


    const InWhereIndex = `( '${ indexChildren.join("', '") }' )`;
    let sql =  `CALL ts_sp_getZonesDemand( ${ fkUser }, `;
    sql += ` "${ InWhereIndex }");`;

    // console.log('sql zonas calientes', sql);
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
                // extraemos las coordenadas de los v√©rtices del pol√≠gono
                service.polygon = h3.h3ToGeoBoundary( service.indexHex, false );
                // extraemos las coordenadas del centro del pol√≠gono
                service.center = h3.h3ToGeo( service.indexHex );
            });

        }

        res.json({
            ok: true,
            data: json
        });

    });
    
});

TaxiRouter.post('/Service/NewOffer', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let fkUser = req.userData.pkUser || 0;
    let body: IBodyOffer = req.body;

    let sql = `CALL ts_sp_addOfferService(`;
    sql += `${ body.pkService },`;
    sql += `${ body.pkOffer }, `;
    sql += `${ body.rateOffer }, `;
    sql += `${ body.isClient }, `;
    sql += `${ body.fkDriver }, `;
    sql += `${ body.fkVehicle },`;
    sql += `${ body.fkJournal || 0 },`;
    sql += `'${ body.codeJournal || '' }'`;
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

TaxiRouter.get('/Offer/Client', [verifyToken], (req: any, res: Response) => {
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

TaxiRouter.get('/Offer/Client/Total', [verifyToken], (req: any, res: Response) => {
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

TaxiRouter.post('/Offer/Accepted/Client', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    
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
            
            // extraer los indices hijos del indice padre
            const indexChildren: string[] = h3.h3ToChildren( indexParent , Server.radiusPentagon);
            const msg = `${ nameUser }, ha aceptado a otro conductor.`;
            const payload = { 
                pkService: body.pkService,
                msg, 
                indexHex: body.indexHex,
                fkUserDriver: body.fkDriver
            };

            indexChildren.forEach( indexHex => {
                Server.io.in( indexHex ).emit( 'disposal-service', payload );
            });

            // notificar al panel que el servicio ya no esta disponible
            const payloadWeb = {
                 indexHex: body.indexHex,
                 pkClient: fkUser
            };
            Server.io.in( 'WEB' ).emit( 'disposal-service', payloadWeb );

            let token = jwt.sign( { dataMonitor: { pkService: body.pkService } }, SEED_KEY, { expiresIn: '1h' } );
            data[0].monitorToken = token;

        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    }); 

});

TaxiRouter.put('/Service/Info/:pk', [verifyToken, verifyDriverClientRole], (req: Request, res: Response) => {
    let pkService = req.params.pk || 0;

    let sql = `CALL ts_sp_getInfoService( ${ pkService } );`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        // creaci√≥n de token para seguimiento en tiempo real
        // let token = jwt.sign( { dataMonitor: { pkService } }, SEED_KEY, { expiresIn: '1h' } );
        // data[0].monitorToken = token;

        res.json({
            ok: true,
            data: data[0]
        });

    }); 
});

TaxiRouter.get('/Service/Info/Monitor', [verifyTokenMonitor], (req: any, res: Response) => {

    let pkService = Number( req.dataMonitor.pkService ) || 0;

    let sql = `CALL ts_sp_getInfoMonitor( ${ pkService } );`;
    // console.log('por que no se imprime esta l√≠nea pkService', sql);
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

TaxiRouter.put('/Service/Delete/:id', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    
    // api donde el cliente, esperando taxi cancela el servicio

    let fkUser = req.userData.pkUser || 0;
    let nameUser = req.userData.nameComplete || '';
    let pkService = Number( req.params.id ) || 0;

    let body = req.body;

    let sql = `CALL ts_sp_deleteService( `;
    sql += `${ pkService }, `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;
    
    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            // obtener el padre de la ubicaci√≥n dada en un radio mas grande
            // const indexParent = h3.h3ToParent( body.indexHex , Server.radiusPather);
            
            // extraer los indices hijos de un pent√°gono con radio 7 del indice padre
            const indexChildren: string[] = h3.kRing( body.indexHex , Server.radiusPentagon);
            const msg = `${ nameUser }, ha cancelado el servicio.`;
            const payload = { 
                pkService, 
                msg, 
                indexHex: body.indexHex 
            };
            indexChildren.forEach( indexHex => {
                Server.io.in( `${indexHex}-${ body.category }` ).emit( 'disposal-service', payload );
            });

            // notificar al panel que se elimin√≥ un servicio
            const payloadWeb = {
                indexHex: body.indexHex,
                pkClient: fkUser
            };
            Server.io.in( 'WEB' ).emit( 'disposal-service', payloadWeb );
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    }); 

});

TaxiRouter.put('/Service/DeleteRun/:id/:isClient', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let pkService = req.params.id || 0;
    let isClient = req.params.isClient || null;
    let fkUser = req.userData.pkUser || 0;
    // let nameUser = req.userData.nameComplete || '';

    // cancelando servicio despues de haber sido aceptado, antes de ir al punto destino

    let validIs = ['true', 'false'];

    if (!validIs.includes( isClient )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Es cliente inv√°lido'
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

TaxiRouter.post('/Offer/Decline', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    // api donde el taxista recahaza un servicio
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

TaxiRouter.post('/Offer/Decline/Client', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    // api donde se recahaza la oferta de un taxista
    let fkUser = req.userData.pkUser || 0;
    let body = req.body;
    let nameUser = req.userData.nameComplete || '';
    // cliente rechaza oferta de conductor

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

        // if (data[0].showError === 0) {
            
        //     // extraer los indices hijos de un pent√°gono con radio 6 del indice padre
        //     // const indexChildren: string[] = h3.kRing( body.indexHex , Server.radiusPentagon);
        //     // const msg = `${ nameUser }, ha cancelado el servicio.`;
        //     // // Server.io.in( body.indexHex ).emit( 'client-cancel-service', { pkService, msg } );
        //     // indexChildren.forEach( indexHex => {
        //     //     Server.io.in( indexHex ).emit( 'disposal-service', { pkService: body.pkService, msg, indexHex: body.indexHex } );
        //     // });

        //     // // notificar al panel que se elimin√≥ un servicio
        //     // // si todo se hizo correctamente notificamos al panel un nuevo tr√°fico
        //     // const payloadWeb = {
        //     //     pkService: body.pkService,
        //     //     msg,
        //     //     indexHex: body.indexHex,
        //     //     pkClient: fkUser
        //     // }
        //     // Server.io.in( 'WEB' ).emit( 'disposal-service', payloadWeb);
        // }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    }); 
});

TaxiRouter.put('/Service/Calification/:id', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    
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

TaxiRouter.get('/Waiting/Driver', [verifyToken, verifyClientRole], (req: any, res: Response) => {

    let fkUser = req.userData.pkUser || 0;
    let pkCategory = req.query.pkCategory || 1;

    const userSk: UserSocket = Users.onFindUserForPk( fkUser );
    // Obtenga todos los hex√°gonos en un anillo k alrededor de un centro dado.
    // El orden de los hex√°gonos no est√° definido
    const indexChildren: string[] = h3.kRing( userSk.indexHex , 1);

    const InWhereIndex = `( '${ indexChildren.join("', '") }' )`;

    let sql = `CALL ts_sp_getDriversWaiting( "${ InWhereIndex }", ${ pkCategory } )`;

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

TaxiRouter.post('/Service/UpdateJournal', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let body = req.body;
    let fkUser = req.userData.pkUser || 0;
    let fkDriver = req.query.pkdriver || 0;

    /**
     * IN `InPkService` bigint,
        IN `InFkOffer` bigint,
        IN `InFkDriver` int,
        IN `InFkUser` int
     */

    let sql = `CALL ts_sp_updateJournal( `;
    sql += `${ body.pkService }, `;
    sql += `${ body.fkOffer }, `;
    sql += `${ fkDriver }, `;
    sql += `${ fkUser } );`;

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

export default TaxiRouter;
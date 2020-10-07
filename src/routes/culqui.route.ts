
import { Request, Response, Router } from "express";
import { verifyToken } from '../middlewares/token.mdd';

import axios from 'axios';
import { ICard, ICustomer, ICarge } from '../interfaces/body_culqui.interface';
import { ICardCulqui, IClientCulqui, ItokenCulqui } from "../interfaces/response_culqui.interface";
import reqIp from "request-ip";
import MysqlClass from "../classes/mysqlConnect.class";

const url_base = 'https://secure.culqi.com';

let culquiRouter = Router();

let MysqlCon = MysqlClass.instance;

culquiRouter.post('/Culqui/Token', [verifyToken] ,( req: Request, res: Response) => {
    
    let body: ICulquiToken = req.body;

    // Make a request for a user with a given ID
    axios.post( url_base + `/v2/tokens`, body, { headers: { Authorization: 'Bearer << llave_publica >>' } })
      .then( (response: any) => {

        res.json({
            ok: true,
            data: response
        });

      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});

culquiRouter.post('/Culqui/Client', [verifyToken] ,(req: any, res: Response) => {

    let body: ICustomer = req.body;

    // Make a request for a user with a given ID
    axios.post( url_base + `/v2/customers`, body, { headers: { Authorization: 'Bearer << llave_publica >>' } })
      .then( (response: any) => {

        res.json({
            ok: true,
            data: response
        });

      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});

culquiRouter.post('/Culqui/Card', [verifyToken] , async (req: any, res: Response) => {

    let body: ICard = req.body;

    // let body: ICardBody = req.body;
    let fkUser = req.userData.pkUser || 0;
    let fkPerson = req.userData.pkPerson || 0;

    const headers = { headers: { Authorization: 'Bearer << llave_publica >>' } };

    // Make a request for a user with a given ID
    const resToken: ItokenCulqui = await axios.post( url_base + `/v2/tokens`, body.body_token, headers);
    const resClient: IClientCulqui = await axios.post( url_base + `/v2/customers`, body.body_customer, headers);

    const bodyCard = {
        token_id: resToken.id,
        customer_id: resClient.id
    };

    // Make a request for a user with a given ID
    axios.post( url_base + `/v2/cards`, bodyCard, headers )
      .then( (response: any) => {

        const resCulqui: ICardCulqui = response;
        
        /**
         *  IN `InFkPerson` int,
            IN `InIdCard` varchar(100),
            IN `InIdClient` varchar(100),
            IN `InCardNumber` varchar(16),
            IN `InLastFour` char(4),
            IN `InBank` varchar(100),
            IN `InCardBrand` varchar(30),
            IN `InCardType` varchar(30),
            IN `InCountryBank` varchar(100),
            IN `InCountryCodeBank` varchar(3),
            IN `InFkUser` int,
            IN `InIpUser`
        */
        
        let sql = `CALL ts_sp_addCard(`
        sql += `${ fkPerson }, `;
        sql += `'${ resCulqui.id }', `;
        sql += `'${ resCulqui.customer_id }', `;
        sql += `'${ resCulqui.source.card_number }', `;
        sql += `'${ resCulqui.source.last_four }', `;
        sql += `'${ resCulqui.source.iin.issuer.name || 'no especificado' }', `;
        sql += `'${ resCulqui.source.iin.issuer.country }', `;
        sql += `'${ resCulqui.source.iin.issuer.country_code }', `;
        sql += `'${ resCulqui.source.iin.card_brand }', `;
        sql += `'${ resCulqui.source.iin.card_type }', `;
        sql += `${ fkUser }, `;
        sql += `'${ reqIp.getClientIp( req ) }', `;
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

        res.json({
            ok: true,
            data: response
        });

      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});

culquiRouter.delete('/Culqui/Card/:id', [verifyToken] ,(req: Request, res: Response) => {

    let idCard = req.params.id || 'xD';

    // Make a request for a user with a given ID
    axios.delete( url_base + `/v2/cards/${ idCard }`, { headers: { Authorization: 'Bearer << llave_publica >>' } })
      .then( (response: any) => {

        res.json({
            ok: true,
            data: response
        });

      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});


// Para realizar un cobro a una tarjeta de débito o crédito es necesario crear un cargo usando un Token o una Tarjeta. 
// Si utilizas tu llave secreta de integración no se realizarán cargos reales, 
// a diferencia del entorno de producción donde enviamos tu petición a los bancos y marcas procesadoras.

culquiRouter.post('/Culqui/charge', [verifyToken] ,(req: Request, res: Response) => {

    let body: ICarge = req.body;

    // Make a request for a user with a given ID
    axios.post( url_base + `/v2/charges`, body ,{ headers: { Authorization: 'Bearer << llave_publica >>' } })
      .then( (response: any) => {

        res.json({
            ok: true,
            data: response
        });

      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});

export default culquiRouter;

// https://secure.culqi.com 

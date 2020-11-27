
import { Request, Response, Router } from "express";

import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';
import { ICard, ICustomer, ICarge, IToken, IRefund, IChargeJournal } from '../interfaces/body_culqui.interface';
import { ICardCulqui, IClientCulqui, ItokenCulqui } from "../interfaces/response_culqui.interface";
import reqIp from "request-ip";
import MysqlClass from "../classes/mysqlConnect.class";
import MainServer from "../classes/mainServer.class";
import { verifyToken, verifyTokenUrl } from '../middlewares/token.mdd';

const url_base = 'https://secure.culqi.com';
let Server = MainServer.instance;

let culquiRouter = Router();

let MysqlCon = MysqlClass.instance;

culquiRouter.post('/Culqui/Token',[] ,( req: Request, res: Response) => {
  
    const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;
    let body: IToken = req.body;

    // tkn_test_ToqpooQTKlFYCpD4

    const conf: AxiosRequestConfig = { 
      headers: { Authorization: culquiKey } , 
      responseType: 'json' 
    };
    
    axios.post( `https://secure.culqi.com/v2/tokens`, body, conf)
      .then( (value: AxiosResponse) => {


        // console.log('res', value);
        res.json({
            ok: true,
            data:  value.data
        });

      })
      .catch( e => {
          res.json({
              ok: false,
              error: e
          });
      } );
      
});

culquiRouter.post('/Culqui/Customer', [] ,(req: Request, res: Response) => {

    let body: ICustomer = req.body;

    const culquiKey = 'Bearer ' + Server.ccSystem.culquiKey;
    // console.log(body);

    const conf: AxiosRequestConfig = { 
      headers: { Authorization: culquiKey } , 
      responseType: 'json' 
    };
    
    axios.post( `https://api.culqi.com/v2/customers`, body, conf)
      .then( (value: AxiosResponse) => {


        // console.log('res', value);
        res.json({
            ok: true,
            data:  value.data
        });

      })
      .catch( e => {
          console.log('error ', e);
          res.status(400).json({
              ok: true,
              error: e
          });
      } );
      
});

culquiRouter.post('/Culqui/Card', [] , async (req: any, res: Response) => {

    let body: ICard = req.body;
    const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;

    let fkUser = 0;
    let fkPerson = 0;

    const conf: AxiosRequestConfig = { 
      headers: { 'Authorization': culquiKey } , 
      responseType: 'json' 
    };


    // Make a request for a user with a given ID
    axios.post( 'https://api.culqi.com/v2/cards', body, conf )
      .then( (value: AxiosResponse) => {

        const resCulqui: ICardCulqui = value.data;
        
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

            data[0].dataCulqui = value.data;
            
            res.json({
                ok: true,
                showError: data[0].showError,
                data: data[0]
            });
            
        });

      })
      .catch( e => {
        console.log('error card', e);
        return res.status(400).json({
            ok: false,
            error: e.response.data
        });
        
      });
      
});

culquiRouter.delete('/Culqui/Card/:id', [verifyToken] ,(req: Request, res: Response) => {

    let idCard = req.params.id || 'xD';
    const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;
    // Make a request for a user with a given ID
    axios.delete( url_base + `/v2/cards/${ idCard }`, { headers: { Authorization: culquiKey } })
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

culquiRouter.post('/Culqui/Charge', [] ,(req: Request, res: Response) => {

    let body: ICarge = req.body;
    const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;

    const conf: AxiosRequestConfig = { 
      headers: { Authorization: culquiKey } , 
      responseType: 'json' 
    };
    // Make a request for a user with a given ID
    axios.post( 'https://api.culqi.com/v2/charges', body , conf)
      .then( (value: AxiosResponse) => {

        res.json({
            ok: true,
            data: value.data
        });

      })
      .catch( e => {
        console.log('error culqui', e);
        return res.json({
            ok: false,
            error: e.response.data
        });
        
      });
      
});

culquiRouter.post('/Culqui/Refund', [] ,(req: Request, res: Response) => {

  let body: IRefund = req.body;
  const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;

  const conf: AxiosRequestConfig = { 
    headers: { Authorization: culquiKey } , 
    responseType: 'json' 
  };
  // Make a request for a user with a given ID
  axios.post( 'https://api.culqi.com/v2/refunds', body , conf)
    .then( (value: AxiosResponse) => {

      res.json({
          ok: true,
          data: value.data
      });

    })
    .catch( e => {
      console.log('error culqui', e);
      return res.json({
          ok: false,
          error: e.response.data
      });
      
    });
    
});

culquiRouter.post('/Culqui/Charge/Journal', [] ,(req: Request, res: Response) => {

  let body: IChargeJournal = req.body;
  const culquiKey = `Bearer ${ Server.ccSystem.culquiKey }`;

  const conf: AxiosRequestConfig = { 
    headers: { Authorization: culquiKey } , 
    responseType: 'json' 
  };
  // Make a request for a user with a given ID
  axios.post( 'https://api.culqi.com/v2/charges', body , conf)
    .then( (value: AxiosResponse) => {
      
      let sql = `CALL ts_sp_updateChargeJournal( ${ body.pkJournal }, '${ value.data.id }' );`;
      MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

        if (error) {
          console.log('error al actualizar cargo jornada');
          return res.json({
            ok: false,
            error,
          });
        }

        res.json({
            ok: true,
            data: value.data,
            dataJournal: data[0]
        });

      });


    })
    .catch( e => {
      console.log('error culqui', e);
      return res.json({
          ok: false,
          error: e.response.data
      });
      
    });
    
});

export default culquiRouter;

// https://secure.culqi.com 

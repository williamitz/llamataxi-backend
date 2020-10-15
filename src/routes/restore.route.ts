import { Request, Response, Router } from "express";
import jwt from 'jsonwebtoken';
import MysqlClass from "../classes/mysqlConnect.class";
import { SEED_KEY } from "../global/environments.global";
import { IEmailRestore, IRestore } from "../interfaces/body_restore.interface";
import nodemailer from "nodemailer";
import { verifyTokenRestore, verifyToken } from '../middlewares/token.mdd';
import IResponse from '../interfaces/resp_promise.interface';
import reqIp from "request-ip";
import bcrypt from 'bcrypt';

let RestoreRouter = Router();

let MysqlCon = MysqlClass.instance;

RestoreRouter.post( '/Email/Restore', [], (req: Request, res: Response) => {

    let body: IEmailRestore = req.body;

    let sql = `CALL as_sp_getUserRestore( '${ body.email }' );`;

    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
        
        let showError = 1;
        if (data[0].pkUser !== 0) {

          showError = 0 + data[0].errRole || 0;

          if (data[0].errRole == 2) {
            return res.json({
              ok: true,
              showError
            });
          }

          let token = jwt.sign( { dataRestore: data[0] }, SEED_KEY, { expiresIn: '1h' } );
          sendEmail( body.email, token, data[0].nameComplete ).then( ( resEmail ) => {

            res.json({
              ok: true,
              showError,
              data: resEmail.data
            });

          }).catch( e => console.error( 'error send ', e ) );

        } else {

          res.json({
            ok: true,
            showError
          });

        }
    
    });

});

RestoreRouter.post( '/User/Restore', [ verifyTokenRestore ], (req: any, res: Response) => {
  let fkUser = req.dataRestore.pkUser || 0;
  let body: IRestore = req.body;

  let sql = `CALL as_sp_restorePassword( `;
  sql += `${ fkUser }, `;
  sql += `'${ bcrypt.hashSync( body.passwordRepit, 10 ) }', `;
  sql += ` '${ reqIp.getClientIp( req ) }' ); `;
  
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
  
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

RestoreRouter.delete( '/Disable/Account', [verifyToken], (req: any, res: Response) => {

  let pkUserToken = req.userData.pkUser || 0;
  let pkPersonToken = req.userData.pkPerson || 0;

  let sql = `CALL as_sp_disableAccount( `;
  sql += `${ pkUserToken }, `;
  sql += `${ pkPersonToken }, `;
  sql += ` '${ reqIp.getClientIp( req ) }' ); `;
  
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
  
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

async function sendEmail( emailTo: string, token: string, name = '' ): Promise<IResponse> {

  return new Promise( (resolve, reject) => {

    // Generate test SMTP service account from ethereal.email

    // create reusable transporter object using the default SMTP transport
    let transporter = nodemailer.createTransport({
        host: "smtp.ethereal.email",
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
          user: 'milan47@ethereal.email', // generated ethereal user
          pass: '1BGcybY1yaYfrwCW4g', // generated ethereal password
        }
    });

    // http://localhost:4200/#/utilities/restore/token

    let htmlMsg = `<b>Restaurar contrase&ntilde;a</b> <br/> `;
    htmlMsg += `<p> `;
    htmlMsg += `Buen día ${ name }, vaya al siguiente enlace para restablecer su contrase&ntilde;a.`;
    htmlMsg += `</p>`;
    htmlMsg += ` 👇👇👇  `;
    htmlMsg += `<br/> `;
    htmlMsg += ` ✅✅🌐  <a target="_blank" href="https://admin.llamataxiperu.com//#/utilities/restore/${ token }"> RESTAURAR </a>  ✅✅<br/> `;
    htmlMsg += `<br/> `;
    htmlMsg += `<br/> `;
    htmlMsg += `Por seguridad restaura tu contraseña antes que el link <b>caduque</b>.`;
    htmlMsg += `<br/> `;
    htmlMsg += `Equipo de atención al cliente <b>llamataxiPerú</b> 👍👍   `;

    // send mail with defined transport object
    const mailOptions = {
      from: 'erika1@ethereal.email', // <foo@example.com> sender address
      to: emailTo, // list of receivers
      subject: "🚨🚕 Llamataxi-perú - Restaurar contraseña 🔑", // Subject line
      // text: "Hello world?", // plain text body
      html: htmlMsg, // html body
    };

    transporter.sendMail( mailOptions, (err, info) =>  {
      if (err) {
        reject( {ok: false, error: err} );
      }

      resolve( {ok: true, data: info } );
    });

  });
    
}

export default RestoreRouter;

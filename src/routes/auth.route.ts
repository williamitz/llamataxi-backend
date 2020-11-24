import { Request, Response, Router } from 'express';
import bcrypt from 'bcrypt';
import reqIp from 'request-ip';
import jwt from 'jsonwebtoken';
import { IBodyUser } from '../interfaces/body_user.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import { SEED_KEY, TWILIO_ID, TWILIO_PHONE, TWILIO_TOKEN } from '../global/environments.global';
import MainServer from '../classes/mainServer.class';
import moment from 'moment';

import twilio from 'twilio';
import { IVerifyAccount } from '../interfaces/body_verify.interface';
import IResponse from '../interfaces/resp_promise.interface';

const clientTwilio = twilio( TWILIO_ID , TWILIO_TOKEN);

const MainSvr = MainServer.instance;
const Mysql = MysqlClass.instance;

let AuthRoutes = Router();

AuthRoutes.post('/singin/user', (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );
    
    let sql = `CALL as_sp_addUser( `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.document }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.userName }', `;
    sql += `'${ passEncrypt }', `;
    sql += `'CLIENT_ROLE', `;
    sql += `${ body.google }, `;
    sql += `${ body.verifyReniec }, `;
    
    //  estos datos solo se toman en cuenta cuando es u conductor
    sql += `'', `; // fecha exp soat
    sql += `0, `; // es empleado

    sql += `0, `;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) { 
            return res.status(401).json({
                ok: false,
                error
            });
        }
        
        let token = '';
        if (data[0].showError === 0) {
            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '30d' } );

            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            MainSvr.io.in( 'WEB' ).emit( 'current-new-user', {pkUser: data[0].pkUser} );
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0],
            token
        });
    });

});

AuthRoutes.post('/singin/client', [], (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );

    let codeVerify = Math.floor( Math.random() * (9999 - 1000) + 1000 );
    let codeVerifExp = moment().add( 30, 'minutes' ).format('YYYY-MM-DD HH:mm:ss'); 
    
    let sql = `CALL as_sp_addClient( `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.document }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.prefixPhone }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.userName }', `;
    sql += `'${ passEncrypt }', `;

    sql += `'${ codeVerify }', `;
    sql += `'${ codeVerifExp }', `;

    sql += `'${ body.codeReferal || 'xD' }', `;

    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `);`;

    Mysql.onExecuteQuery( sql, async (error: any, data: any[]) => {

        if (error) { 
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let token = '';
        if (data[0].showError === 0) {
            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '1h' } );
            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            MainSvr.io.in( 'WEB' ).emit( 'current-new-user', {pkUser: data[0].pkUser} );
            
            // console.log('enviando mensjae a ', `${ contact.prefixPhone } ${ contact.phone }`);
            
            const resSend = await sendCodeVeryf( body.prefixPhone || '', body.phone || '', codeVerify );
            
            data[0].sendMsg = resSend.ok;
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0],
            token
        });
    });

});

AuthRoutes.post('/Verify/Client', [], (req: any, res: Response) => {
    
    // IN `InPkUser` int,
    // IN `InCode` char(4),
    // IN `InName` varchar(40)

    let body: IVerifyAccount = req.body;

    
    let sql = `CALL as_sp_verifyClient(  `;
    sql += `${ body.pkUser }, `;
    sql += `'${ body.codeVerif }', `;
    sql += `'${ body.name }'`;
    sql += `);`;

    Mysql.onExecuteQuery( sql, async (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let token = '';

        if ( data[0].showError === 0 ) {
            token = jwt.sign( { dataUser: body }, SEED_KEY, { expiresIn: '30d' } );
            body.showError = data[0].showError;

            body.codeVerif = '';
        }

        res.json({
            ok: true,
            token,
            showError: data[0].showError,
            data: body
        });

    });

});

AuthRoutes.post('/Confirm/Phone', [], (req: Request, res: Response) => {
    let body: IVerifyAccount = req.body;

    // IN `InPkUser` int,
    // IN `InPkPerson` int,
    // IN `InFkNationality` int,
    // IN `InPhone` varchar(15)

    let codeVerify = Math.floor( Math.random() * (9999 - 1000) + 1000 );
    let codeVerifExp = moment().add( 30, 'minutes' ).format('YYYY-MM-DD HH:mm:ss'); 
    
    let sql = `CALL as_sp_confirmPhone(  `;
    sql += `${ body.pkUser }, `;
    sql += `${ body.pkPerson }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.phone }', `;
    sql += `'${ codeVerify }', `;
    sql += `'${ codeVerifExp }'`;
    sql += `);`;

    Mysql.onExecuteQuery( sql, async (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if ( data[0].showError === 0 ) {
            
            // console.log('enviando mensjae a ', `${ contact.prefixPhone } ${ contact.phone }`);
            const resSend = await sendCodeVeryf( body.prefixPhone || '', body.phone || '', codeVerify );
            
            data[0].sendMsg = resSend.ok;;
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });

});

AuthRoutes.post('/Resend/Code', [], (req: Request, res: Response) => {
    let body: IVerifyAccount = req.body;

    // IN `InPkUser` int,
    // IN `InPkPerson` int,
    // IN `InFkNationality` int,
    // IN `InPhone` varchar(15)

    let codeVerify = Math.floor( Math.random() * (9999 - 1000) + 1000 );
    let codeVerifExp = moment().add( 30, 'minutes' ).format('YYYY-MM-DD HH:mm:ss'); 
    
    let sql = `CALL as_sp_resendCode(  `;
    sql += `${ body.pkUser }, `;
    sql += `${ body.pkPerson }, `;
    sql += `'${ codeVerify }', `;
    sql += `'${ codeVerifExp }' `;
    sql += `);`;

    Mysql.onExecuteQuery( sql, async (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if ( data[0].showError === 0 ) {
            
            // console.log('enviando mensjae a ', `${ contact.prefixPhone } ${ contact.phone }`);
            const resSend = await sendCodeVeryf( body.prefixPhone || '', body.phone || '', codeVerify );
            
            data[0].sendMsg = resSend.ok;
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0]
        });

    });

});

AuthRoutes.post('/singin/driver', (req: Request, res: Response) => {
    let body: IBodyUser = req.body; 

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );
    let nameUpper = body.name.toUpperCase();
    let surnameUpper = body.surname.toUpperCase();

    let sql = `CALL as_sp_addDriver(${ body.fkTypeDocument }`;
    sql += `, ${ body.fkNationality }`;
    sql += `, '${ nameUpper.trim() }'`;
    sql += `, '${ surnameUpper.trim() }'`;
    sql += `, '${ body.document }' `;
    sql += `, ${ body.verifyReniec } `;
    sql += `, '${ body.email }' `;
    sql += `, '${ body.phone }' `;
    sql += `, '${ body.brithDate }' `;
    sql += `, '${ body.sex }' `;

    sql += `, '${ body.codeReferal || 'xD' }' `;
    
    sql += `, '${ body.userName }' `;
    sql += `, '${ passEncrypt }' `;

    sql += `, '${ body.dateLicenseExpiration }' `;
    sql += `, ${ body.isEmployee } `;
    sql += `, '${ body.numberPlate }' `;
    sql += `, ${ body.year } `;
    sql += `, '${ body.color }'`;
    sql += `, '${ body.dateSoatExpiration }'`;
    
    sql += `, ${ body.isProper }`;
    sql += `, '${ reqIp.getClientIp(req) }');`

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) { 
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let token = '';
        if (data[0].showError === 0) {
            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '30d' } );

            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            MainSvr.io.in( 'WEB' ).emit( 'current-new-user', {pkUser: data[0].pkUser} )
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            data: data[0],
            token
        });
    });

});

AuthRoutes.post('/Login/Client', (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let sql = `CALL as_sp_loginClient( '${ body.userName }' );`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            }); 
        }

        let dataString = JSON.stringify(data);
        let json = JSON.parse(dataString);

        // console.log('data user', json);
        let token = '';
        let showError = Number( json.showError ) || 0;
        if (showError === 0) {

            if (!bcrypt.compareSync( body.userPassword, data[0].userPassword )) {
                return res.json({
                    ok: true,
                    showError: showError + 2,
                });
            }

            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            MainSvr.io.in( 'WEB' ).emit( 'current-new-traffic', {pkUser: data[0].pkUser} );

            delete data[0].userPassword;
            // delete data[0].showError;

            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '30d' } );
        }

        res.json({
            ok: true,
            showError,
            data: data[0],
            token
        });

    });

});

AuthRoutes.post('/Login/Driver', (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let sql = `CALL as_sp_loginDriver( '${ body.userName }' );`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            }); 
        }


        let token = '';
        let showError = data[0].showError || 0;
        if (showError === 0) {

            if (!bcrypt.compareSync( body.userPassword, data[0].userPassword )) {
                return res.json({
                    ok: true,
                    showError: showError + 2,
                });
            }

            // si todo se hizo correctamente notificamos al panel un nuevo tráfico
            MainSvr.io.in( 'WEB' ).emit( 'current-new-traffic', {pkUser: data[0].pkUser} );

            delete data[0].userPassword;
            delete data[0].showError;

            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '30d' } );
        }

        res.json({
            ok: true,
            showError,
            data: data[0],
            token
        });

    });

});

AuthRoutes.post('/Login/Web', (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );

    let sql = `CALL as_sp_loginWeb( '${ body.userName }', '${ passEncrypt }' );`;
    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        

        let token = '';
        let showError = data[0].showError || 0;
        if (showError === 0) {

            if (!bcrypt.compareSync( body.userPassword, data[0].userPassword )) {
                return res.json({
                    ok: true,
                    showError: showError + 2,
                });
            }

            delete data[0].userPassword;
            delete data[0].showError;

            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '1d' } );
        }

        res.json({
            ok: true,
            showError,
            data: data[0],
            token
        });

    });
});

AuthRoutes.get('/nationality/GetAll', (req: Request, res: Response) => {
    
    let qCountry = req.query.qCountry || '';

    let sql = `CALL as_sp_getListNationality( '${ qCountry }' );`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
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

AuthRoutes.get('/typeDocument/GetAll', (req: Request, res: Response) => {
    
    let sql = `CALL as_sp_getListTypeDocument( );`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
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

AuthRoutes.post('/authorization', (req: Request, res: Response) => {

    let token = req.get('Authorization') || '';

    jwt.verify( token, SEED_KEY, (error: any, decoded: any) => {

        if (error) {
            return res.json({
                ok: false,
                error
            });
        }


        res.json({
            ok: true,
            messgae: 'token valid :D'
        });

    });
    

});

AuthRoutes.post('/auth/token', (req: Request, res: Response) => {
    let token = req.get('Authorization') || 'xD';
    let rolesInvalid = ['CLIENT_ROLE', 'DRIVER_ROLE'];

    jwt.verify( token, SEED_KEY, (error, decoded: any) => {
        if (error) {
            return res.status(401).json({
                ok: false,
                error
            });
        }

        if (!decoded.dataUser) {
            return res.status(401).json({
                ok: false,
                error: {
                    message: 'Junior como hacker te vas a morir de hambre 🖕💀🖕'
                }
            });
        }

        if ( rolesInvalid.includes(decoded.dataUser.role) ) {
            
            return res.status(401).json({
                ok: false,
                error: {
                    message: 'No tiene permisos para ingresar a la web'
                }
            });
        }

        res.json({
            ok: true
        });
    });
});

function sendCodeVeryf( prefix: string, phone: string, code: number ): Promise<IResponse> {

    return new Promise( (resolve) => {
        
        clientTwilio.messages
        .create({
                from: TWILIO_PHONE, // de
                to: `${ prefix } ${ phone }`, // para
                body: `Llamataxi Perú - ${ code }, su código de verificación expira en unos minutos`
        }, (error: any, res) => {

            if (error) {
                console.log('Error al enviar mensaje twilio', error);
                return resolve({ ok: false, error });
            }
        
            resolve({ ok: true, data: res.sid  });

            // data[0].sendMsg = twlioRes.sid !== '' ? true : false;
            // console.log('Mensaje enviado ', res.sid);
        });
            
            
    });
    
}

export default AuthRoutes;
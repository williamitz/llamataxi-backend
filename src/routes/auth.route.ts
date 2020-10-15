import { Request, Response, Router } from 'express';
import bcrypt from 'bcrypt';
import reqIp from 'request-ip';
import jwt from 'jsonwebtoken';
import { IBodyUser } from '../interfaces/body_user.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import { SEED_KEY } from '../global/environments.global';
import MainServer from '../classes/mainServer.class';

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

AuthRoutes.post('/singin/driver', (req: Request, res: Response) => {
    let body: IBodyUser = req.body; 

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );

    let sql = `CALL as_sp_addDriver(${ body.fkTypeDocument }`;
    sql += `, ${ body.fkNationality }`;
    sql += `, '${ body.name }'`;
    sql += `, '${ body.surname }'`;
    sql += `, '${ body.document }' `;
    sql += `, ${ body.verifyReniec } `;
    sql += `, '${ body.email }' `;
    sql += `, '${ body.phone }' `;
    sql += `, '${ body.brithDate }' `;
    sql += `, '${ body.sex }' `;
    sql += `, '${ body.userName }' `;
    sql += `, '${ passEncrypt }' `;
    sql += `, 'DRIVER_ROLE'`;
    sql += `, ${ body.google } `;
    sql += `, '${ body.dateLicenseExpiration }' `;
    sql += `, ${ body.isEmployee } `;
    sql += `, '${ body.numberPlate }', ${ body.year }, '${ body.color }', '${ body.dateSoatExpiration }' `;
    sql += `, ${ body.isProper }, 0, '${ reqIp.getClientIp(req) }');`;

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
            return res.json({
                ok: false,
                error
            });
        }

        if (decoded.dataUser.role === 'restore') {
            return res.status(401).json({
                ok: false,
                error: {
                    message: 'Junior como hacker te vas a morir de hambre 💀💀',
                    decoded
                }
            });
        }

        if ( rolesInvalid.includes(decoded.dataUser.role) ) {
            
            return res.json({
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


export default AuthRoutes;
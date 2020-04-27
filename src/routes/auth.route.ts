import { Request, Response, Router } from 'express';
import bcrypt from 'bcrypt';
import reqIp from 'request-ip';
import jwt from 'jsonwebtoken';
import { IBodyUser } from '../interfaces/body_user.interface';
import MysqlClass from '../classes/mysqlConnect.class';
import { SEED_KEY } from '../global/environments.global';

const Mysql = MysqlClass.instance;

let AuthRoutes = Router();

AuthRoutes.post('/singin/user', (req: Request, res: Response) => {
    let body: IBodyUser = req.body;

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );
    
    let sql = `CALL as_login( ${ body.fkTypeDocument }, ${ body.fkNationality }, '${ body.name }', '${ body.surname }', '${ body.document }', '${ body.email }', '${ body.phone }', '${ body.sex }', '${ body.userName }', '${ passEncrypt }', 'USER_CLIENT_ROLE', ${ body.google }, 0, ${ reqIp.getClientIp( req ) });`;

    Mysql.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(401).json({
                ok: false,
                error
            });
        }
        
        let token = '';
        if (data[0].showError === 0) {
            token = jwt.sign( { dataUser: data[0] }, SEED_KEY, { expiresIn: '1d' } );
        }

        res.json({
            ok: true,
            showError: data[0].showError,
            token
        });
    });

});
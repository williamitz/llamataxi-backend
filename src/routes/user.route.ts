import { Request, Response, Router } from 'express';
import { verifyToken, verifyWebmasterRole } from '../middlewares/token.mdd';
import { IBodyUser, IUserProfile } from '../interfaces/body_user.interface';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { SEED_KEY } from '../global/environments.global';

let UserRouter = Router();
let MysqlCnn = MysqlClass.instance;

UserRouter.put('/user/updateProfile/:id', verifyToken, (req: any, res: Response) => {
    let body: IBodyUser = req.body;

    let pkParam = req.params.id || 0;

    let pkUserToken = req.userData.pkUser || 0;
    
    if (pkParam !== pkUserToken) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Fatal error, comuniquese con el web master'
            }
        });
    }


    // backtis Alt + 96

    let sql = `CALL as_sp_updateProfile( ${ pkParam }, ${ body.fkTypeDocument }, '${ body.document }', '${ body.name }', '${ body.surname }', '${ body.dateBirth }', ${ pkUserToken }, '${ reqIp.getClientIp(req) }' );`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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

UserRouter.get( '/User/Get', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {

    let InPage = req.query.page || 1;
    let rowsForPage = req.query.rowsForPage || 10;
    let qName = req.query.qName || '';
    let qEmail = req.query.qEmail || '';
    let qUser = req.query.qUser || '';
    let qRole = req.query.qRole || '';
    let showInactive = req.query.showInactive.toString() || 'true';

    let statusValid = ['true', 'false'];
    if (!statusValid.includes( showInactive )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: `Los estados válidos son ${ statusValid.join(', ') }`
            }
        });
    }

    let sql = `CALL as_sp_getListUser(${ InPage }, ${ rowsForPage }, '${ qName }', '${ qEmail }', '${ qUser }', '${ qRole }', ${ showInactive });`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let sqlOverall = `CALL as_sp_overallPageUser('${ qName }', '${ qEmail }', '${ qUser }', '${ qRole }', ${ showInactive });`;

        MysqlCnn.onExecuteQuery( sqlOverall, (errorOverall: any, dataOverall: any[]) => {
            if (errorOverall) {
                return res.status(400).json({
                    ok: false,
                    error: errorOverall
                });
            }

            res.json({
                ok: true,
                total: dataOverall[0].total,
                data
            });
        });

    });

} );

UserRouter.post('/User/Add', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {
    let body: IBodyUser = req.body;
    let fkUser = req.userData.pkUser || 0;
    let rolesValid = ['ADMIN_ROLE', 'ATTENTION_ROLE'];

    if (!rolesValid.includes( body.role )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles válidos son ' + rolesValid.join(', ')
            }
        });
    }

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );
    
    let sql = `CALL as_sp_addUser( ${ body.fkTypeDocument }, ${ body.fkNationality }, '${ body.name }', '${ body.surname }', '${ body.document }', '${ body.email }', '${ body.phone }', '${ body.userName }', '${ passEncrypt }', '${ body.role }', ${ body.google }, ${ fkUser }, '${ reqIp.getClientIp( req ) }' );`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
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
            data: data[0],
            token
        });
    });

});

UserRouter.get('/User/Profile/:pkUser', [verifyToken, verifyWebmasterRole], (req: Request, res: Response) => {
    let pkUser = req.params.pkUser || 0;
    let sql =  `CALL as_sp_getProfileUser(${ pkUser });`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) { 
            return res.status(401).json({
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

UserRouter.put('/User/Profile/Update', [verifyToken], (req: any, res: Response) => {
    let body: IBodyUser = req.body;
    let pkUserToken = req.userData.pkUser || 0;

    /**
     *  IN `InPkUser` int,
        IN `InFkTypeDoc` int,
        IN `InFkNationality` int,
        IN `InDocument` varchar(15),
        
        IN `InName` varchar(50),
        IN `InSurname` varchar(50),
        IN `InEmail` varchar(50),
        IN `InPhone` varchar(20),
        IN `InSex` CHAR(1),
        IN `InDateBirth` varchar(12),
        
        IN `InFkUser` int,
        IN `InIpUser` varchar(20)
     */

    
    let sql = `CALL as_sp_updateProfileUser( `;

    sql += `${ body.pkUser }, `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.document }', `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.sex }', `;
    sql += `'${ body.birthDate }', `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

    MysqlCnn.onExecuteQuery( sql, ( error: any, data: any[] ) => {
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

UserRouter.delete('/User/:pkUser/:status', [verifyToken, verifyWebmasterRole], (req: any, res: Response) => {

    let pkUser = req.params.pkUser || 0;
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
    /**
     *  IN `InPkUser` int,
        IN `InStatus` tinyint,
        IN `InObservation` VARCHAR(100),
        IN `InFkUser` int,
        IN `InIpUser` varchar(20)
     */
    
    let sql = `CALL as_sp_deleteUser(${ pkUser }, ${ status }, '${ observation }', ${ fkUser }, '${ reqIp.getClientIp( req ) }');`;
    

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
export default UserRouter;
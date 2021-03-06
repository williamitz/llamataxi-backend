import { Request, Response, Router } from 'express';
import { verifyToken, verifyWebmasterRole, verifyClientRole, verifyDriverRole, verifyWebRoles } from '../middlewares/token.mdd';
import { IBodyUser, IUserProfile, IPassword, IPasswordWeb } from '../interfaces/body_user.interface';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { SEED_KEY } from '../global/environments.global';
import { IProfile } from '../interfaces/body_profile.interface';
import { IProfileWeb } from '../interfaces/body_profileWeb.interface';

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
    let qVerified = req.query.qVerified || 2;
    let qConnect = req.query.qConnect || 2;
    let showInactive = req.query.showInactive.toString() || 'true';

    let statusValid = ['true', 'false'];
    if (!statusValid.includes( showInactive )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: `Los estados v??lidos son ${ statusValid.join(', ') }`
            }
        });
    }

    let sql = `CALL as_sp_getListUser(${ InPage }, `;
    sql += `${ rowsForPage }, `;
    sql += `'${ qName }', `;
    sql += `'${ qEmail }', `;
    sql += `'${ qUser }', `;
    sql += `'${ qRole }', `;
    sql += `${ qVerified }, `;
    sql += `${ qConnect }, `;
    sql += `${ showInactive });`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }
        
        let sqlOverall = `CALL as_sp_overallPageUser(`;
        sqlOverall += `'${ qName }', `;
        sqlOverall += `'${ qEmail }', `;
        sqlOverall += `'${ qUser }', `;
        sqlOverall += `'${ qRole }', `;
        sqlOverall += `${ qVerified }, `;
        sqlOverall += `${ qConnect }, `;
        sqlOverall += `${ showInactive });`;

        console.log('sql overall', sqlOverall);

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
    let rolesValid = ['ADMIN_ROLE', 'ATTENTION_ROLE', 'DRIVER_ROLE'];

    if (!rolesValid.includes( body.role )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los roles v??lidos son ' + rolesValid.join(', ')
            }
        });
    }

    let passEncrypt = bcrypt.hashSync( body.userPassword, 10 );
    
    let sql = `CALL as_sp_addUser( ${ body.fkTypeDocument }, `;
    sql += `${ body.fkNationality }, `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.document }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.userName }', `;
    sql += `'${ passEncrypt }', `;
    sql += `'${ body.role }', `;
    sql += `${ body.google }, `;
    sql += `${ body.verifyReniec }, `;

    sql += `'${ body.dateLicenseExpiration }', `;
    sql += `${ body.isEmployee }, `;

    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

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
                message: 'Los estados v??lidos son ' + statusValid.join(', ')
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


// apis para configuraci??n del perfil de los usuarios app m??vil

UserRouter.get('/Client/Profile/App', [verifyToken, verifyClientRole ], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let sql = `CALL cu_sp_getProfileClient(${ pkUserToken });`;

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

UserRouter.post('/User/Profile/Update/App', [verifyToken, verifyClientRole], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    let body: IProfile = req.body;
    /*
    `cu_sp_updateProfileClient`(
        IN `InPkUser` int,
        IN `InPkPerson` int,
        IN `InFkNationality` int,
        IN `InFkTypeDoc` int,
        IN `InDocument` varchar(20),
        IN `InName` varchar(50),
        IN `InSurname` varchar(50),
        IN `InPhone` varchar(20),
        IN `InEmail` varchar(80),
        IN `InSex` CHAR(1),
        IN `InBirthDate` varchar(20),
        IN `InIpUser` varchar(20))
    */
    let sql = `CALL cu_sp_updateProfileClient(`;
    sql += `${ pkUserToken }, `;
    sql += `${ pkPersonToken }, `;
    sql += `${ body.fkNationality }, `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `'${ body.document }', `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.sex }', `;
    sql += `'${ body.brithDate }', `;
    sql += `'${ body.aboutMe }', `;
    sql += `'${ reqIp.getClientIp( req ) }' `;
    sql += `);`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) { 
            return res.status(401).json({
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

UserRouter.get('/Driver/Profile/App', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let sql = `CALL cu_sp_getProfileDriver(${ pkUserToken });`;

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

UserRouter.post('/Driver/Profile/Update/App', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    let pkDriverToken = req.userData.pkDriver || 0;
    let body: IProfile = req.body;

    let sql = `CALL cu_sp_updateProfileDriver(`;
    sql += `${ pkUserToken }, `;
    sql += `${ pkPersonToken }, `;
    sql += `${ pkDriverToken }, `;
    sql += `${ body.fkNationality }, `;
    sql += `${ body.fkTypeDocument }, `;
    sql += `'${ body.document }', `;
    sql += `'${ body.name }', `;
    sql += `'${ body.surname }', `;
    sql += `'${ body.phone }', `;
    sql += `'${ body.email }', `;
    sql += `'${ body.sex }', `;
    sql += `'${ body.brithDate }', `;
    sql += `'${ body.aboutMe }', `;
    sql += `'${ body.dateLicenseExpiration }', `;
    sql += `${ body.isEmployee }, `;
    sql += `'${ reqIp.getClientIp( req ) }' `;
    sql += `);`; 

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

UserRouter.post( '/User/ChangePass', [verifyToken], (req: any, res: Response) => {
    
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    let body: IPassword = req.body;

    let sql = `CALL as_sp_getPasswordUser(${ pkUserToken });`;

    MysqlCnn.onExecuteQuery( sql, (error: any, data: any[]) => {
        if (error) { 
            return res.status(400).json({
                ok: false,
                error
            });
        }

        let passDatabase = data[0].password || 'xD';

        if (!bcrypt.compareSync( body.passwordOld, passDatabase )) {
            return res.json({
                ok: true,
                showError: 8
            });
        }
        /*
        IN `InPkUser` int,
        IN `InPkPerson` int,
        IN `InPassword` varchar(200),
        IN `InIp` varchar(20) */

        let sqlChange = `CALL as_sp_changePassword(`;
        sqlChange += `${ pkUserToken }, `;
        sqlChange += `${ pkPersonToken }, `;
        sqlChange += `'${ bcrypt.hashSync( body.password, 10 ) }', `;
        sqlChange += `'${ reqIp.getClientIp( req ) }'`;
        sqlChange += `);`;

        MysqlCnn.onExecuteQuery( sqlChange, (errorChnage: any, dataChange: any[]) => {

            if (errorChnage) { 
                return res.status(400).json({
                    ok: false,
                    error: errorChnage
                });
            }

            res.json({
                ok: true,
                showError: dataChange[0].showError,
                data: dataChange[0]
            });

        });

    });
});

UserRouter.put('/User/ChangePass/Web', [verifyToken, verifyWebRoles], (req: any, res: Response) => {

    let pkUserToken = req.userData.pkUser || 0;
    let body: IPasswordWeb = req.body;

    let sqlChange = `CALL as_sp_updatePassUser(`;
    sqlChange += `${ body.pkUser }, `;
    sqlChange += `'${ bcrypt.hashSync( body.password, 10 ) }', `;
    sqlChange += `${ pkUserToken }, `;
    sqlChange += `'${ reqIp.getClientIp( req ) }'`;
    sqlChange += `);`;

    MysqlCnn.onExecuteQuery( sqlChange, (error: any, data: any[]) => {

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

UserRouter.get('/Profile/Web', [verifyToken, verifyWebRoles], (req: any, res: Response) => {

    let pkUserToken = req.userData.pkUser || 0;

    let sqlChange = `CALL as_sp_getProfileWeb( ${ pkUserToken } );`;

    MysqlCnn.onExecuteQuery( sqlChange, (error: any, data: any[]) => {

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

UserRouter.put('/Profile/Web', [verifyToken, verifyWebRoles], (req: any, res: Response) => {

    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    let body: IProfileWeb = req.body;

    /**
     * IN `InName` varchar(40),
        IN `InSurname` varchar(40),
        IN `InFkDocument` tinyint,
        IN `InFkNationality` int,
        IN `InDocument` varchar(20),
        IN `InPhone` varchar(20),
        IN `InEmail` varchar(100),
        IN `InIpUser` varchar(20)
     */

    let sql = `CALL as_sp_updateProfileWeb( `;
    sql += `${ pkUserToken },`;
    sql += `${ pkPersonToken },`;
    sql += `'${ body.name }',`;
    sql += `'${ body.surname }',`;
    sql += `${ body.fkTypeDocument },`;
    sql += `${ body.fkNationality },`;
    sql += `'${ body.document }',`;
    sql += `'${ body.phone }',`;
    sql += `'${ body.email }',`;
    sql += `'${ reqIp.getClientIp( req ) }'`;
    sql += `); `;

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
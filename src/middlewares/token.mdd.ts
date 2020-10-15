import {Request ,Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { SEED_KEY } from '../global/environments.global';

export let verifyToken = ( req: any, res: Response, next: NextFunction ) => {
    
    let token = req.get('Authorization') || '';
    
    jwt.verify( token, SEED_KEY, (error: any, decoded: any) => {

        if (error) {
            return res.status(401).json({
                ok: false,
                error
            });
        }

        req.userData = decoded.dataUser;

        next();

    });

}

export let verifyTokenRestore = ( req: any, res: Response, next: NextFunction ) => {
    
    let token = req.get('AuthRestore') || '';
    
    jwt.verify( token, SEED_KEY, (error: any, decoded: any) => {

        if (error) {
            return res.status(401).json({
                ok: false,
                error
            });
        }
        
        if (!decoded.dataRestore.role || decoded.dataRestore.role !== 'restore') {
            return res.status(401).json({
                ok: false,
                error: {
                    message: 'Junior como hacker te vas a morir de hambre 💀💀'
                }
            });
        }

        req.dataRestore = decoded.dataRestore;

        next();

    });

}

export let verifyWebmasterRole = ( req: any, res: Response, next: NextFunction ) => {
    
    let role = req.userData.role || 'xD';

    let rolesAllow = ['WEBMASTER_ROLE', 'ADMIN_ROLE', 'ATTENTION_ROLE'];

    if ( !rolesAllow.includes( role )) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Acceso restringido!, comuniquese con el administrador.'
            }
        });
    }

    next();
}

export let verifyTokenUrl = ( req: any, res: Response, next: NextFunction ) => {
    
    let token = String( req.query.token ) || 'xD';
    
    jwt.verify( token, SEED_KEY, (error: any, decoded: any) => {

        if (error) {
            return res.status(401).json({
                ok: false,
                error
            });
        }

        req.userData = decoded.dataUser;

        next();

    });

}

export let verifyClientRole = ( req: any, res: Response, next: NextFunction ) => {
    
    let role = req.userData.role || 'xD';
    let rolesAllow = ['CLIENT_ROLE'];

    if ( !rolesAllow.includes( role )) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Acceso restringido!, comuniquese con el administrador.'
            }
        });
    }

    next();
}

export let verifyDriverRole = ( req: any, res: Response, next: NextFunction ) => {
    
    let role = req.userData.role || 'xD';

    let rolesAllow = ['DRIVER_ROLE'];

    if ( !rolesAllow.includes( role )) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Acceso restringido!, comuniquese con el administrador.'
            }
        });
    }

    next();
}

export let verifyDriverClientRole = ( req: any, res: Response, next: NextFunction ) => {
    
    let role = req.userData.role || 'xD';

    let rolesAllow = ['DRIVER_ROLE', 'CLIENT_ROLE'];

    if ( !rolesAllow.includes( role )) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Acceso restringido!, comuniquese con el administrador.'
            }
        });
    }

    next();
}

export let verifyWebRoles = ( req: any, res: Response, next: NextFunction ) => {
    
    let role = req.userData.role || 'xD';

    let rolesAllow = ['ADMIN_ROLE', 'WEBMASTER_ROLE', 'ATTENTION_ROLE'];

    if ( !rolesAllow.includes( role )) {
        return res.status(401).json({
            ok: false,
            error: {
                message: 'Acceso restringido!, comuniquese con el administrador.'
            }
        });
    }

    next();
}
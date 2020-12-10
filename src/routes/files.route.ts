import { Router, Request, Response } from 'express';
import { verifyTokenUrl, verifyToken } from '../middlewares/token.mdd';
import path from 'path';
import fs from 'fs';

let FilesRouter = Router();

FilesRouter.get('/User/Img/Get/:fileName', [verifyTokenUrl] , (req: Request, res: Response) => {
    
    let nameFile = req.params.fileName || 'xD';
    let pathImg = path.resolve( __dirname, '../upload/user/', nameFile );
    let pathDefault = path.resolve( __dirname, '../assets/no-image.jpg/' );

    if (!fs.existsSync( pathImg )) {
        return res.sendFile(pathDefault);
    }
    
    res.sendFile(pathImg);
});

FilesRouter.get('/Driver/Img/Get/:entity/:idEntity/:fileName', [verifyTokenUrl] , (req: Request, res: Response) => {
    
    let entity = req.params.entity.toUpperCase() || 'xD';
    let pkEntity = req.params.idEntity || 0;
    let pkDriver = req.query.idDriver || 0;

    let entitysValid = ['DRIVER', 'VEHICLE'];

    if (!entitysValid.includes( entity )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipo válidos son ' + entitysValid.join(', ')
            }
        });
    }

    let pathDefault = path.resolve( __dirname, '../assets/no-image.jpg/' );
    let nameFile = req.params.fileName || 'xD';

    let pathImg = path.resolve( __dirname, `../upload/driver/${ pkEntity }/`, nameFile );

    if (entity === 'VEHICLE') {
        pathImg = path.resolve( __dirname, `../upload/driver/${ pkDriver }/vehicle-${ pkEntity }/`, nameFile );
    }


    if (!fs.existsSync( pathImg )) {
        return res.sendFile(pathDefault);
    }
    
    res.sendFile(pathImg);
});

FilesRouter.get('/Img/Get/:module/:fileName', [verifyTokenUrl] , (req: Request, res: Response) => {
    
    let modulesValid = ['award', 'voucher']

    let module = req.params.module || 'voucher';
    let nameFile = req.params.fileName || 'xD';
    let pathImg = path.resolve( __dirname, `../upload/${ module }/`, nameFile );
    let pathDefault = path.resolve( __dirname, '../assets/no-image.jpg/' );

    if (!fs.existsSync( pathImg )) {
        return res.sendFile(pathDefault);
    }

    if (!modulesValid.includes( module )) {
        return res.sendFile(pathDefault);
    }
    
    res.sendFile(pathImg);
});

FilesRouter.get('/Dowland/:module/:fileName', [] , (req: Request, res: Response) => {
    
    let modulesValid = ['voucher']

    let module = req.params.module || 'voucher';
    let nameFile = req.params.fileName || 'xD';
    let pathImg = path.resolve( __dirname, `../upload/${ module }/`, nameFile );
    let pathDefault = path.resolve( __dirname, '../assets/no-image.jpg/' );

    if (!fs.existsSync( pathImg )) {
        res.download(pathDefault);
    }

    if (!modulesValid.includes( module )) {
        res.download(pathDefault);
    }
    
    res.download(pathImg);
});
export default FilesRouter;
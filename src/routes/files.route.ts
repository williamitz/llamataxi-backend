import { Router, Request, Response } from 'express';
import { verifyTokenUrl } from '../middlewares/token.mdd';
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

export default FilesRouter;
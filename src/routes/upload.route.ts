import { Request, Response, Router } from 'express';
import fileUpload from 'express-fileupload';
import fs from 'fs';
import path from 'path';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';
import { verifyToken } from '../middlewares/token.mdd';
import FileSystem from '../classes/fileSystem.class';
import IFile from '../interfaces/file.interfaces';

const Mysql = MysqlClass.instance;

let UploadRoutes = Router();
UploadRoutes.use( fileUpload() );

UploadRoutes.put('/upload/:module/:id/', [verifyToken] , (req: Request, res: Response) => {
    
    let module = req.params.module.toLocaleLowerCase() || '';
    let idEntity = Number( req.params.id ) || 0;

    let modulesValid = ['user', 'award', 'voucher'];
    let imgValid = ['jpg', 'png', 'jpeg'];

    if (!req.files || Object.keys(req.files || []).length === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se adjuntaron archivos'
            }
        });
    }

    if (modulesValid.indexOf( module ) < 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipos válidos son: ' + modulesValid.join(', ')
            }
        });
    }

    let file: any = req.files.file;

    if (!file) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se encontró archivo a subir'
            }
        });
    }

    let arrName = file.name.split('.');
    let extensionFile = arrName[ arrName.length - 1 ].toLocaleLowerCase();

    if (imgValid.indexOf( extensionFile ) < 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipos de imágenes válidos son: ' + imgValid.join(', ')
            }
        });
    }
    const date = new Date().getSeconds();
    let nameFile = `${ idEntity }-photo${ date }.png`;

    if ( module === 'user' ) {
        nameFile = `${ idEntity }-photo${ date }.png`;
    }else if( module === 'award' ) {
        nameFile = `${ idEntity }-award${ date }.png`;
    }else if( module === 'voucher' ) {
        nameFile = `${ idEntity }-liquidation${ date }.png`;
    }

    let pathImg = path.resolve(__dirname, `../upload/${ module }/${ nameFile }`);

    file.mv(pathImg, (error: any) => {
        if (error){
            return res.status(500).json({
                ok: false,
                error
            });
        }

        if (module === 'user') {            
            updatedImgUser(idEntity, nameFile, req, res);
        }

        if (module === 'award') {            
            updatedImgAward(idEntity, nameFile, req, res);
        }

        if (module === 'voucher') {            
            updatedVoucherLiqu(idEntity, nameFile, req, res);
        }
    
    });

});

function updatedImgUser( pkUser: number, nameFile: string, req: Request , res: Response ) {

    let sql = `CALL as_sp_updatePhotoUser(${ pkUser }, '${ nameFile }', 0, '${ reqIp.getClientIp( req ) }');`;
    Mysql.onExecuteQuery(sql, ( error: any, data: any[] ) => {
        if (error) {
            let pathImg = path.resolve(__dirname, '../upload/user/', nameFile);
            if ( fs.existsSync( pathImg ) ) {
                fs.unlinkSync(pathImg);
            }

            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            let oldImg = path.resolve(__dirname, '../upload/user/', data[0].oldImg || 'xD.png' );
            if ( fs.existsSync( oldImg ) ) {
                fs.unlinkSync(oldImg);
            }
            
        }

        res.json({
            ok: true,
            data: [{ nameFile }],
            messge: 'Se subió imagen exitosamente'
        });
    });

}

function updatedImgAward( pkAward: number, nameFile: string, req: Request , res: Response ) {

    let sql = `CALL aw_sp_updateImgAward(${ pkAward }, '${ nameFile }');`;

    Mysql.onExecuteQuery(sql, ( error: any, data: any[] ) => {
        if (error) {
            let pathImg = path.resolve(__dirname, '../upload/award/', nameFile);
            if ( fs.existsSync( pathImg ) ) {
                fs.unlinkSync(pathImg);
            }

            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            let oldImg = path.resolve(__dirname, '../upload/award/', data[0].oldImg );
            if ( fs.existsSync( oldImg ) ) {
                fs.unlinkSync(oldImg);
            }
            
        }

        res.json({
            ok: true,
            data: [{ nameFile }],
            messge: getErrorImg( data[0].showError )
        });
    });

}

function updatedVoucherLiqu( pkLiquidation: number, nameFile: string, req: Request , res: Response ) {

    let sql = `CALL ts_sp_updateVoucherLiq(${ pkLiquidation }, '${ nameFile }');`;

    Mysql.onExecuteQuery(sql, ( error: any, data: any[] ) => {
        if (error) {
            let pathImg = path.resolve(__dirname, '../upload/voucher/', nameFile);
            if ( fs.existsSync( pathImg ) ) {
                fs.unlinkSync(pathImg);
            }

            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].showError === 0) {
            let oldImg = path.resolve(__dirname, '../upload/voucher/', data[0].oldImg );
            if ( fs.existsSync( oldImg ) ) {
                fs.unlinkSync(oldImg);
            }
            
        }

        res.json({
            ok: true,
            data: [{ nameFile }],
            messge: getErrorImg( data[0].showError )
        });
    });

}



UploadRoutes.put('/upload/driver/:entity/:id/:document', [verifyToken], (req: any, res: Response) => {
    let entity = req.params.entity.toUpperCase() || '';
    let idEntity = Number( req.params.id ) || 0;
    let document = req.params.document.toUpperCase() || '';
    let admin = req.query.admin || 'false';
    let pkDriver = req.userData.pkDriver || 0;
    if (admin === 'true') {
        pkDriver = req.query.pkDriver;
    }
    
    let entitysValid = ['DRIVER', 'VEHICLE'];
    let imgValid = ['jpg', 'png', 'jpeg', 'pdf'];
    let documentsValid = [
        'LICENSE'
        ,'PHOTO_CHECK'
        ,'CRIMINAL_RECORD'
        ,'POLICIAL_RECORD'
        ,'SOAT'
        ,'PROPERTY_CARD'
        ,'TAXI_FRONTAL'
        ,'TAXI_BACK'
        ,'TAXI_INTERIOR'
    ];
    
    if (!req.files || Object.keys(req.files || []).length === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se adjuntaron archivos'
            }
        });
    }

    let file: IFile = req.files.file;

    if (!file) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se encontró archivo a subir'
            }
        });
    }

    if (!entitysValid.includes(entity)) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Las entidades válidas son: ' + entitysValid.join(', ')
            }
        });
    }


    let arrName = file.name.split('.');
    let extensionFile = arrName[ arrName.length - 1 ].toLowerCase();

    if ( !imgValid.includes( extensionFile ) ) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipos de imágenes válidos son: ' + imgValid.join(', ')
            }
        });
    }
        
    if ( !documentsValid.includes( document ) ) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipos de documentos válidos son: ' + documentsValid.join(', ')
            }
        });
    }
    
    const time = new Date().getTime();
    let pathImg = FileSystem.buildPathDriver( idEntity );

    if (entity === 'VEHICLE') {
        pathImg = FileSystem.buildPathVehicle( pkDriver , idEntity );
    }

    let img = `${ document }-${ time }.${ extensionFile }`;
    pathImg = path.resolve( pathImg , img);

    file.mv(pathImg, (error: any) => {
        if (error){
            return res.status(500).json({
                ok: false,
                error
            });
        }

        updateFileDriver( entity, idEntity, document, img, req, res);
    
    });
    
});

function updateFileDriver( entity: string, idEntity: number, document: string, img: string, req: any, res: Response ) {
    
    let pkUser = req.userData.pkUser;

    let sql = `CALL as_sp_updateFilesDriver( ${ idEntity }, '${ entity }', '${ document }', '${ img }', ${ pkUser }, '${ reqIp.getClientIp( req ) }' );`;

    Mysql.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
            return res.status(400).json({
                ok: false,
                error
            });
        }

        if (data[0].oldImg != '' && data[0].oldImg ) {
            let imgOld = data[0].oldImg;
            let oldPath = path.resolve( __dirname, '../upload/driver/', `${ idEntity }/${ imgOld }`);
            if (fs.existsSync( oldPath )) {
                fs.unlinkSync( oldPath );
            }
        }

        res.json({
            ok: true,
            data: data[0],
            newFile: img,
            document,
            message: 'Se subió exitosamente'
        });
    });

}

function getErrorImg( showError: number ) {
    let arrErr = showError === 0 ? ['Se subió imagen exitosamente'] : ['Alerta'];

    if ( showError & 1 ) {
        arrErr.push('no se encontró premio')
    }

    return arrErr.join(', ');
}

export default UploadRoutes;
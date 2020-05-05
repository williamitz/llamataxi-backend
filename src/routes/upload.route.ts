import { Request, Response, Router } from 'express';
import fileUpload from 'express-fileupload';
import fs from 'fs';
import path from 'path';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';
import { verifyToken } from '../middlewares/token.mdd';
import FileSystem from '../classes/fileSystem.class';

const Mysql = MysqlClass.instance;

let UploadRoutes = Router();
UploadRoutes.use( fileUpload() );

UploadRoutes.put('/upload/:module/:id/:typeFile', verifyToken , (req: Request, res: Response) => {
    
    let module = req.params.module.toLocaleLowerCase() || '';
    let idEntity = Number( req.params.id ) || 0;
    let typeFile = req.params.typeFile.toUpperCase() || '';

    let modulesValid = ['user', 'driver'];
    let imgValid = ['jpg', 'png', 'jpeg', 'pdf'];
    let typesValid = [
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
    let nameFile = '';
    let pathImg = '';
    if (module === 'user') {

        nameFile = `${ idEntity }-photo.png`;
        pathImg = path.resolve(__dirname, `../upload/${ module }/${ nameFile }`);
        
    }else if (module === 'driver') {
        
        if ( typesValid.indexOf( typeFile ) === -1 ) {
            return res.status(400).json({
                ok: false,
                error: {
                    message: 'Los tipos de documentos válidos son: ' + typesValid.join(', ')
                }
            });
        }

        pathImg = FileSystem.buildPathDriver( idEntity );
        const time = new Date().getTime();
        pathImg = path.resolve( pathImg , `${ typeFile }-${ time }.${ extensionFile }`);
    }


    file.mv(pathImg, (error: any) => {
        if (error){
            return res.status(500).json({
                ok: false,
                error
            });
        }

        if (module === 'user') {            
            updatedImgUser(idEntity, nameFile, req, res);
        }else if( module === 'driver' ) {
            
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

            res.json({
                ok: true,
                messge: 'Se subió imagen exitosamente'
            });
        });

}

export default UploadRoutes;
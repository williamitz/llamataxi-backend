import { Request, Response, Router } from 'express';
import fileUpload from 'express-fileupload';
import fs from 'fs';
import path from 'path';
import reqIp from 'request-ip';
import MysqlClass from '../classes/mysqlConnect.class';

const Mysql = MysqlClass.instance;

let UploadRoutes = Router();
UploadRoutes.use( fileUpload() );

UploadRoutes.put('/upload/:module/:id', (req: Request, res: Response) => {
    
    let module = req.params.module.toLocaleLowerCase() || '';
    let idEntity = Number( req.params.id ) || 0;

    let modulesValid = ['user'];
    let typesValid = ['jpg', 'png', 'jpeg'];

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

    let arrName = file.name.split('.');
    let extensionFile = arrName[ arrName.length - 1 ].toLocaleLowerCase();

    if (typesValid.indexOf( extensionFile ) < 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los tipos de imágenes válidos son: ' + typesValid.join(', ')
            }
        });
    }

    file.mv(`/upload/${ module }/`, (error: any) => {
        if (error){
            return res.status(500).json({
                ok: false,
                error
            });
        }

        if (module === 'user') {            
            updatedImgUser(idEntity, '0', req, res);
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
                ok: true
            });
        });

}

export default UploadRoutes;
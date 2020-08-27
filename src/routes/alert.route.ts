import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import reqIp from "request-ip";
import { verifyToken, verifyDriverClientRole } from '../middlewares/token.mdd';
import { IAlert } from "../interfaces/body_alert.interface";

let sosRouter = Router();

let MysqlCon = MysqlClass.instance;

sosRouter.post('/Alert/Add', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {

    let body: IAlert = req.body;
    let pkPersonToken = req.userData.pkPerson || 0;
    let pkUserToken = req.userData.pkUser || 0;

    // IN `InFkService` int,
    // IN `InFkPerson` int,
    // IN `InIsClient` tinyint,
    // IN `InLat` float(30, 20),
    // IN `InLng` float(30, 20),
    // IN `InFkUser` int,
    // IN `InIpUser` varchar(20)

    let sql = `CALL ts_sp_addAlert(`;
    sql += `${ body.fkService }, `;
    sql += `${ pkPersonToken }, `;
    sql += `${ body.isClient }, `;
    sql += `${ body.lat }, `;
    sql += `${ body.lng }, `;
    sql += `${ pkUserToken }, `;
    sql += `'${ reqIp.getClientIp( req ) }' );`;

    MysqlCon.onExecuteQuery(sql, ( error: any, data: any[] ) => {

        if (error) {

          return res.status(400).json({
            ok: false,
            error,
          });

        }

        res.json({
          ok: true,
          showError: data[0].showError,
          data: data[0]
        });

    });

});

export default sosRouter;
import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { verifyDriverClientRole } from '../middlewares/token.mdd';
import { IContact } from "../interfaces/body_contact.interface";

let ContactRouter = Router();

let MysqlCon = MysqlClass.instance;

ContactRouter.post( '/Contact/Add', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let body: IContact = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    /**
     * IN `InFkNationality` int,
        IN `InName` varchar(50),
        IN `InSurname` varchar(50),
        IN `InEmail` varchar(100),
        IN `InPhone` varchar(20),
        IN `InFkPerson` int,
        IN `InPkUser` int,
        IN `InIpUser` varchar(20)
     */

    let sql = `CALL ts_sp_addContact( `;
    sql += `${body.fkNationality}, `;
    sql += `'${body.name}' ,`;
    sql += `'${body.surname}', `;
    sql += `'${body.email}', `;
    sql += `'${body.phone}', `;
    sql += `${pkPersonToken}, `;
    sql += `${pkUserToken}, `;
    sql += `'${reqIp.getClientIp(req)}' );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
        res.json({
          ok: true,
          showError: data[0].showError,
          data: data[0],
        });
    });
});

ContactRouter.put( '/Contact/Update', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let body: IContact = req.body;
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    /**
     * IN `InFkNationality` int,
        IN `InName` varchar(50),
        IN `InSurname` varchar(50),
        IN `InEmail` varchar(100),
        IN `InPhone` varchar(20),
        IN `InFkPerson` int,
        IN `InPkUser` int,
        IN `InIpUser` varchar(20)
     */

    let sql = `CALL ts_sp_updateContact( `;
    sql += `${body.pkContact}, `;
    sql += `${body.fkNationality}, `;
    sql += `'${body.name}' ,`;
    sql += `'${body.surname}', `;
    sql += `'${body.email}', `;
    sql += `'${body.phone}', `;
    sql += `${pkPersonToken}, `;
    sql += `${pkUserToken}, `;
    sql += `'${reqIp.getClientIp(req)}' );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
        res.json({
          ok: true,
          showError: data[0].showError,
          data: data[0],
        });
    });
});

ContactRouter.delete('/Contact/:id/:status', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;
    let pkContact = req.params.id || 0;
    let status = req.params.status || 'false';
    let statusValid = [ 'true', 'false'];

    if (!statusValid.includes( status )) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'Los estados válidos son ' + statusValid.join(', ')
            }
        });
    }

    let sql = `CALL ts_sp_deleteContact( `;
    sql += `${pkContact}, `;
    sql += `${pkPersonToken}, `;
    sql += `${status}, `;    
    sql += `${pkUserToken}, `;
    sql += `'${reqIp.getClientIp(req)}' );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
        res.json({
          ok: true,
          showError: data[0].showError,
          data: data[0],
        });
    });
});

ContactRouter.get('/Contact/Get', [verifyToken, verifyDriverClientRole], (req: any, res: Response) => {
    let pkUserToken = req.userData.pkUser || 0;
    let pkPersonToken = req.userData.pkPerson || 0;


    let sql = `CALL ts_sp_getListContacts( ${pkPersonToken} );`;
    
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
        if (error) {
          return res.status(400).json({
            ok: false,
            error,
          });
        }
        res.json({
          ok: true,
          data
        });
    });
});

export default ContactRouter;
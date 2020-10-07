import { Request, Response, Router } from "express";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { ICardBody } from '../interfaces/body_card.interface';

let CardRouter = Router();

let MysqlCon = MysqlClass.instance;

CardRouter.post('/Card/Add', [verifyToken], (req: any, res: Response) => {
    
    let body: ICardBody = req.body;
    let fkUser = req.userData.pkUser || 0;
    let fkPerson = req.userData.pkPerson || 0;
    
    /**
     *  IN `InFkPerson` int,
        IN `InIdCard` varchar(100),
        IN `InIdClient` varchar(100),
        IN `InCardNumber` varchar(16),
        IN `InLastFour` char(4),
        IN `InBank` varchar(100),
        IN `InCardBrand` varchar(30),
        IN `InCardType` varchar(30),
        IN `InCountryBank` varchar(100),
        IN `InCountryCodeBank` varchar(3),
        IN `InFkUser` int,
        IN `InIpUser`
     */
    
    let sql = `CALL ts_sp_addCard(`
    sql += `${ fkPerson }, `;
    sql += `'${ body.idCardCulqui }', `;
    sql += `'${ body.idClientCulqui }', `;
    sql += `'${ body.cardNumber }', `;
    sql += `'${ body.lastFour }', `;
    sql += `'${ body.bank }', `;
    sql += `'${ body.brandCard }', `;
    sql += `'${ body.typeCard }', `;
    sql += `'${ body.countryBank }', `;
    sql += `'${ body.countryCodeBank }', `;
    sql += `${ fkUser }, `;
    sql += `'${ reqIp.getClientIp( req ) }', `;
    sql += `);`;

    MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {
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

export default CardRouter;
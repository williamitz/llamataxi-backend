import { Request, Response, Router } from "express";
import { IBodyBrand } from "./../interfaces/body_brand.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let CardRouter = Router();

let MysqlCon = MysqlClass.instance;

CardRouter.post('/Card/Add', [verifyToken], (req: Request, res: Response) => {
    
});

export default CardRouter;
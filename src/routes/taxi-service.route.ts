import { Request, Response, Router } from "express";
import { verifyToken } from "../middlewares/token.mdd"
import MainServer from '../classes/mainServer.class';


let TaxiServiceRouter = Router();

let Server = MainServer.instance;

TaxiServiceRouter.get('/Journal/GetForHour', [verifyToken], (req: Request, res: Response) => {
    
    const data = Server.getJournal();
    if (data.pkJournal === 0) {
        return res.status(400).json({
            ok: false,
            error: {
                message: 'No se expecificó las jornadas de tarifa'
            }
        });
    }
    res.json({
        ok: true,
        data
    });
                  
});

export default TaxiServiceRouter;
const OneSignal = require('onesignal-node');    
import { OS_APP, OS_KEY } from '../global/environments.global';
import { CreateNotificationBody } from 'onesignal-node/lib/types';
import { Request, Response, Router } from "express";
import { verifyToken } from '../middlewares/token.mdd';
import { Ipush } from '../interfaces/body_push.interface';

let osRouter = Router();

// With custom API endpoint
const client = new OneSignal.Client(OS_APP, OS_KEY, { apiRoot: 'https://onesignal.com/api/v1'});

osRouter.post('/Push/Send', [verifyToken], (req: Request, res: Response) => {

    let body: Ipush = req.body;

    const bodyNoty: CreateNotificationBody = {
        contents: {
          'es': body.message,
          'en': 'New notification',
        },
        headings: {
            'es': body.title,
            'en': 'New notification',
        },
        include_player_ids: body.osId,
        data: body.data
    };
    
    client.createNotification(bodyNoty).then((osRes: any) => {

        res.json({
            ok: true,
            data: { message: 'Mensaje enviado' }
        });

    }).catch( (e: any) => {
        res.status(400).json({
            ok: false,
            error: e
        });
    });
});

export default osRouter;

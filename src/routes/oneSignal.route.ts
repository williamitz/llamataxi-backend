const OneSignal = require('onesignal-node');    
import { OS_APP, OS_KEY } from '../global/environments.global';
import { CreateNotificationBody } from 'onesignal-node/lib/types';
import { Request, Response, Router } from "express";
import { verifyToken } from '../middlewares/token.mdd';
import { Ipush } from '../interfaces/body_push.interface';
import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';

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
        template_id: body.template_id || '', // '9d2ad516-a641-4d44-b000-15d6adbbebdc',
        headings: {
            'es': body.title,
            'en': 'New notification',
        },
        // include_external_user_ids: body.osId,
        // channel_for_external_user_ids: "push",
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

osRouter.post('/new/Push', [verifyToken], (req: Request, res: Response) => {

    let body: Ipush = req.body;

    const bodyNoty: CreateNotificationBody = {
        contents: {
          'es': body.message,
          'en': 'New notification',
        },
        template_id: body.template_id || '', // '9d2ad516-a641-4d44-b000-15d6adbbebdc',
        headings: {
            'es': body.title,
            'en': 'New notification',
        },
        include_external_user_ids: body.osId,
        // channel_for_external_user_ids: "push",
        // include_player_ids: body.osId,
        data: body.data
    };
    
    const conf: AxiosRequestConfig = { 
        headers: { "Authorization": OS_KEY },
        params: bodyNoty
      };
  
      // console.log('header culqui', conf);
      
    axios.post( `https://onesignal.com/api/v1/notifications`, bodyNoty, conf)
    .then( (value: AxiosResponse) => {


        // console.log('res', value);
        res.json({
            ok: true,
            data: { message: 'Mensaje enviado' }
        });

    })
    .catch( e => {

        res.status(400).json({
            ok: false,
            error: e
        });
    } );
} );
export default osRouter;

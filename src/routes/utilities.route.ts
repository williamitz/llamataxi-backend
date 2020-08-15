const axios = require('axios');
import { Request, Response, Router } from 'express';
import bcrypt from 'bcrypt';
import reqIp from 'request-ip';

let UtilRoutes = Router();

UtilRoutes.get('/dni', (req: any, res: Response) => {

    let qDni = req.query.q || '00000000';

    // Make a request for a user with a given ID
    axios.get(`https://api.reniec.cloud/dni/${ qDni }`)
      .then( (response: any) => {
        res.json({
            ok: true,
            data: response.data || null
        });
      })
      .catch( (error: any) => {
        
        return res.status(400).json({
            ok: false,
            error
        });
        
      });
      
});
    

export default UtilRoutes;
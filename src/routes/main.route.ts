import { Router } from 'express';
import UploadRoutes from './upload.route';
import NavPaterRouter from './nav-pather.route';

let MainRouter = Router();

MainRouter.use( UploadRoutes );
MainRouter.use( NavPaterRouter );

export default MainRouter;
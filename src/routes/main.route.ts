import { Router } from 'express';
import UploadRoutes from './upload.route';
import NavPaterRouter from './nav-father.route';
import AuthRoutes from './auth.route';
import UserRouter from './user.route';

let MainRouter = Router();

MainRouter.use( UploadRoutes );
MainRouter.use( NavPaterRouter );
MainRouter.use( AuthRoutes );
MainRouter.use( UserRouter );

export default MainRouter;
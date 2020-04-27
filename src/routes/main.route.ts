import { Router } from 'express';
import UploadRoutes from './upload.route';

let MainRouter = Router();

MainRouter.use( UploadRoutes );

export default MainRouter;
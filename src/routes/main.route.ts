import { Router } from "express";
import UploadRoutes from "./upload.route";
import AuthRoutes from "./auth.route";
import UserRouter from "./user.route";
import NotificationRouter from "./notification.route";
import ApplicationRouter from "./application.route";
import BrandRouter from "./brand.route";
import CategoryRouter from "./category.route";
import ModelRouter from "./model.route";
import NavChildrenRouter from "./nav-children.route";
import MenuRoleRouter from "./menu-role.route";
import VehicleDriverRouter from "./vehicle-driver.route";
import NavFatherRouter from "./nav-father.route";
import FilesRouter from "./files.route";
import DriverRoutes from "./driver.route";
import MessageRouter from './message.route';

let MainRouter = Router();

MainRouter.use(AuthRoutes);
MainRouter.use(UploadRoutes);
MainRouter.use(NavFatherRouter);
MainRouter.use(ApplicationRouter);
MainRouter.use(BrandRouter);
MainRouter.use(CategoryRouter);
MainRouter.use(ModelRouter);
MainRouter.use(NavChildrenRouter);
MainRouter.use(MenuRoleRouter);
MainRouter.use(VehicleDriverRouter);
MainRouter.use(NotificationRouter);
MainRouter.use(UserRouter);
MainRouter.use(FilesRouter);
MainRouter.use(DriverRoutes);
MainRouter.use(MessageRouter);

export default MainRouter;

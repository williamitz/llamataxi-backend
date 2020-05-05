import { Router } from "express";
import UploadRoutes from "./upload.route";
import NavFatherRouter from "./nav-father.route";
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

let MainRouter = Router();

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
MainRouter.use(AuthRoutes);
MainRouter.use(UserRouter);

export default MainRouter;

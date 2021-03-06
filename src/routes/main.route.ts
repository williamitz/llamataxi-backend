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
import VehicleRouter from "./vehicle-driver.route";
import NavFatherRouter from "./nav-father.route";
import FilesRouter from "./files.route";
import DriverRoutes from "./driver.route";
import MessageRouter from './message.route';

import JournalRouter from './journal.route';
import RateRouter from './rate.route';
import osRouter from "./oneSignal.route";
import UtilRoutes from './utilities.route';
import ChartsRouter from "./charts.rotes";
import ContactRouter from "./contacts.route";
import TrackerRouter from "./tracker.router";
import TaxiRouter from './taxi-service.route';
import HistoryRouter from "./history.route";
import StatRouter from "./statistics.route";
import RestoreRouter from "./restore.route";
import ReferalRouter from "./configReferal.route";
import CouponRouter from "./coupon.route";
import CJouRouter from "./configJournal.route";
import JDriverRouter from "./journalDriver.route";
import AccBankRouter from "./accountDriver.route";
import LiquRouter from "./liquidation.route";
import AwardRouter from "./award.route";
import culquiRouter from "./culqui.route";
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
MainRouter.use(VehicleRouter);
MainRouter.use(NotificationRouter);
MainRouter.use(UserRouter);
MainRouter.use(FilesRouter);
MainRouter.use(DriverRoutes);
MainRouter.use(MessageRouter);

MainRouter.use( TaxiRouter )

MainRouter.use(JournalRouter);
MainRouter.use(RateRouter);
MainRouter.use(osRouter);

MainRouter.use( UtilRoutes );
MainRouter.use( ChartsRouter );
MainRouter.use( ContactRouter );
MainRouter.use( TrackerRouter );
MainRouter.use( HistoryRouter );
MainRouter.use( StatRouter );
MainRouter.use( RestoreRouter );
MainRouter.use( ReferalRouter );
MainRouter.use( CouponRouter );
MainRouter.use( CJouRouter );
MainRouter.use( JDriverRouter );
MainRouter.use( AccBankRouter );
MainRouter.use( LiquRouter );
MainRouter.use( AwardRouter );
MainRouter.use( culquiRouter );


export default MainRouter;

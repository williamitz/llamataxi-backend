import { Request, Response, Router } from "express";
import { IBodyVehicleDriver } from "./../interfaces/body_vehicle_driver.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let VehicleDriverRouter = Router();

let MysqlCon = MysqlClass.instance;

VehicleDriverRouter.get("/VehicleDriver/Get", (req: Request, res: Response) => {
  let body: IBodyVehicleDriver = req.body;
  let page = req.query.page || 1;
  let q = req.query.q || "";
  let fkDriver = req.query.fkDriver || 0;
  let fkBrand = req.query.fkBrand || 0;
  let fkModel = req.query.fkModel || 0;
  let isProper = req.query.isProper || 0;
  let numberPlate = req.query.numberPlate || "";
  let year = req.query.year || 0;
  let color = req.query.color || "";
  let showInactive = req.query.showInactive || true;
  let sql = `CALL as_sp_getListVehicleDriver(${page},
      ${fkDriver},
      ${fkBrand},
      ${fkModel},
      ${isProper},
      '${numberPlate}',
      ${year},
      '${color}',
      ${showInactive}
    );`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    let sqlOverall = `CALL as_sp_overallPageVehicleDriver(  ${fkDriver},
        ${fkBrand},
        ${fkModel},
        ${isProper},
        '${numberPlate}',
        ${year},
        '${color}',
        ${showInactive});`;

    MysqlCon.onExecuteQuery(
      sqlOverall,
      (errorOverall: any, dataOverall: any[]) => {
        if (errorOverall) {
          return res.status(400).json({
            ok: false,
            error: errorOverall,
          });
        }

        res.json({
          ok: true,
          data: data,
          total: dataOverall[0].total,
        });
      }
    );
  });
});
VehicleDriverRouter.get("/Driver/GetAll", (req: Request, res: Response) => {
  let sql = `CALL as_sp_getListDriverAll();`;
  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    res.json({
      ok: true,
      data: data,
    });
  });
});
VehicleDriverRouter.post("/VehicleDriver/Add", (req: any, res: Response) => {
  let body: IBodyVehicleDriver = req.body;

  let pkUserToken = 1; //req.userData.pkUser || 0;
  let sql = `CALL as_sp_addVehicleDriver( ${body.fkDriver || null},
    ${body.fkBrand || null},
    ${body.fkModel || null},
    ${body.isProper || null},
    '${body.imgLease || ""}',
    '${body.numberPlate || ""}',
    ${body.year || null},
    '${body.color || ""}',
    '${body.imgSoat || ""}',
    '${body.dateSoatExpiration || ""}',
    '${body.imgPropertyCard || ""}',
     ${pkUserToken}, 
    '${reqIp.getClientIp(req)}');`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }
    res.json({
      ok: true,
      showError: data[0].showError,
      data: data[0],
    });
  });
});

VehicleDriverRouter.put(
  "/VehicleDriver/Update/:id",
  (req: any, res: Response) => {
    let body: IBodyVehicleDriver = req.body;

    let pkParam = req.params.id || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateVehicleDriver( ${pkParam}, 
      ${body.fkDriver || null},
      ${body.fkBrand || null},
      ${body.fkModel || null},
      ${body.isProper || null},
      '${body.imgLease || ""}',
      '${body.numberPlate || ""}',
      ${body.year || null},
      '${body.color || ""}',
      '${body.imgSoat || ""}',
      '${body.dateSoatExpiration || ""}',
      '${body.imgPropertyCard || ""}',
    ${pkUserToken} ,  
    '${reqIp.getClientIp(req)}' );`;

    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }
      res.json({
        ok: true,
        showError: data[0].showError,
        data: data[0],
      });
    });
  }
);

VehicleDriverRouter.delete(
  "/VehicleDriver/Delete/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteVehicleDriver( '${pkParam}', 
      ${status},
      ${pkUserToken} , 
      '${reqIp.getClientIp(req)}' );`;
    MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
      if (error) {
        return res.status(400).json({
          ok: false,
          error,
        });
      }
      res.json({
        ok: true,
        showError: data[0].showError,
        data: data[0],
      });
    });
  }
);
export default VehicleDriverRouter;

import { Request, Response, Router } from "express";
import { IBodyVehicleDriver } from "./../interfaces/body_vehicle_driver.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";

let VehicleDriverRouter = Router();

let MysqlCon = MysqlClass.instance;

VehicleDriverRouter.get(
  "/getListVehicleDriver",
  (req: Request, res: Response) => {
    let body: IBodyVehicleDriver = req.body;
    let sql = `CALL as_sp_getListVehicleDriver(${body.fkDriver || null},
    ${body.fkBrand || null},
    ${body.fkModel || null},
    ${body.isProper || null},
    '${body.numberPlate || ""}',
    ${body.year || null},
    '${body.color || ""}',
    ${body.statusRegister || 2}
    );`;
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
  }
);

VehicleDriverRouter.post("/addVehicleDriver", (req: any, res: Response) => {
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
      data: data[0],
    });
  });
});

VehicleDriverRouter.put(
  "/updateVehicleDriver/:id",
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
        data: data[0],
      });
    });
  }
);

VehicleDriverRouter.delete(
  "/deleteVehicleDriver/:id/:statusRegister",
  (req: Request, res: Response) => {
    let pkParam = req.params.id || 0;
    let status = req.params.statusRegister || 0;
    let pkUserToken = 1; //req.userData.pkUser || 0;
    let sql = `CALL as_sp_deleteVehicleDriver( '${pkParam}', 
      '${status}',
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
        data: data[0],
      });
    });
  }
);
export default VehicleDriverRouter;

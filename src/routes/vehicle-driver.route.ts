import { Request, Response, Router } from "express";
import { IBodyVehicleDriver } from "./../interfaces/body_vehicle_driver.interface";
import MysqlClass from "./../classes/mysqlConnect.class";
import { verifyToken } from "./../middlewares/token.mdd";
import reqIp from "request-ip";
import { verifyDriverRole } from '../middlewares/token.mdd';
import { IBodyVehicleApp } from '../interfaces/body_vehicle_driver.interface';

let VehicleRouter = Router();

let MysqlCon = MysqlClass.instance;

VehicleRouter.get("/VehicleDriver/Get", (req: Request, res: Response) => {
  // let body: IBodyVehicleDriver = req.body;
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

VehicleRouter.get("/Driver/GetAll", (req: Request, res: Response) => {
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

VehicleRouter.post("/Vehicle/Add", [verifyToken], (req: any, res: Response) => {
  let body: IBodyVehicleDriver = req.body;

  let fkUser = req.userData.pkUser || 0;

  let sql = `CALL as_sp_addVehicle( ${body.fkDriver}, ${ body.fkPerson }, ${ body.fkCategory }, ${body.fkBrand}, ${body.fkModel}, ${body.isProper}, '${body.numberPlate.toUpperCase()}', ${body.year}, '${body.color}', '${body.dateSoatExpiration}', ${ body.verified }, ${fkUser}, '${reqIp.getClientIp(req)}');`;

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

VehicleRouter.put("/Vehicle/Update/:id", [verifyToken], (req: any, res: Response) => {
    let body: IBodyVehicleDriver = req.body;

    let pkVehicle = req.params.id || 0;
    let fkUser =req.userData.pkUser || 0;

    let sql = `CALL as_sp_updateVehicle( ${ pkVehicle }, ${body.fkDriver}, ${ body.fkPerson }, ${ body.fkCategory }, ${body.fkBrand}, ${body.fkModel}, ${body.isProper}, '${body.numberPlate.toUpperCase()}', ${body.year}, '${body.color}', '${body.dateSoatExpiration}', ${fkUser}, '${reqIp.getClientIp(req)}');`;

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

VehicleRouter.delete("/Vehicle/Delete/:id/:driver/:status", [verifyToken],  (req: any, res: Response) => {
    let pkVehicle = req.params.id || 0;
    let fkDriver = req.params.driver || 0;
    let status = req.params.status || 0;

    let pkUserToken = req.userData.pkUser || 0;

    let sql = `CALL as_sp_deleteVehicle(${pkVehicle}, ${ fkDriver }, ${status}, ${pkUserToken}, '${reqIp.getClientIp(req)}' );`;

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

VehicleRouter.post('/Vehicle/Add/App', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {
    
  let body: IBodyVehicleApp = req.body;

  let pkUserToken = req.userData.pkUser || 0;
  let pkDriverToken = req.userData.pkDriver || 0;
  let pkPersonToken = req.userData.pkPerson || 0;

  let sql = `CALL ts_sp_addVehicle(`;
  sql += `${ pkDriverToken }, `;
  sql += `${ pkPersonToken }, `;
  sql += `${ body.isProper }, `;
  sql += `'${ body.numberPlate.toUpperCase() }', `;
  sql += `${ body.year }, `;
  sql += `'${ body.color }', `;
  sql += `'${ body.dateSoatExpiration }', `;
  sql += `${ pkUserToken }, `;
  sql += `'${ reqIp.getClientIp(req) }' );`;

  MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    res.json({
      ok: true,
      showError: data[0].showError,
      data: data[0]
    });

  });

});

VehicleRouter.put('/Vehicle/Update/App/:id', [verifyToken, verifyDriverRole], (req: any, res: Response ) =>{
    
  // ts_sp_updateVehicle
  /*
  IN `InPkVehicle` INT, 
  IN `InPkDriver` INT, 
  IN `InFkPerson` INT, 
  IN `InIsProper` TINYINT, 
  IN `InNumberPlate` VARCHAR(15), 
  IN `InYear` INT, 
  IN `InColor` VARCHAR(20), 
  IN `InDateSoatExpiration` VARCHAR(20), 
  IN `InPkUser` INT, 
  IN `InIpUser` VARCHAR(20) 
  */
  let pkVehicle = req.params.id || 0;
  let body: IBodyVehicleApp = req.body;

  let pkUserToken = req.userData.pkUser || 0;
  let pkDriverToken = req.userData.pkDriver || 0;
  let pkPersonToken = req.userData.pkPerson || 0;

 let sql = `CALL ts_sp_updateVehicle(`;
  sql += `${ pkVehicle }, `;
  sql += `${ pkDriverToken }, `;
  sql += `${ pkPersonToken }, `;
  sql += `${ body.isProper }, `;
  sql += `'${ body.numberPlate.toUpperCase() }', `;
  sql += `${ body.year }, `;
  sql += `'${ body.color }', `;
  sql += `'${ body.dateSoatExpiration }', `;
  sql += `${ pkUserToken }, `;
  sql += `'${ reqIp.getClientIp(req) }' );`;

  MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    res.json({
      ok: true,
      showError: data[0].showError,
      data: data[0]
    });

  });

});

VehicleRouter.delete('/Vehicle/Del/App/:id', [verifyToken, verifyDriverRole], (req: any, res: Response ) => {
  
  let pkVehicle = req.params.id || 0;
  let pkUserToken = req.userData.pkUser || 0;
  let pkDriverToken = req.userData.pkDriver || 0;
  let pkPersonToken = req.userData.pkPerson || 0;

  let sql = `CALL ts_sp_deleteVehicle(`;
  sql += `${ pkVehicle }, `;
  sql += `${ pkDriverToken }, `;
  sql += `${ pkPersonToken }, `;
  sql += `${ pkUserToken }, `;
  sql += `'${ reqIp.getClientIp( req ) }' `;
  sql += `);`;

  MysqlCon.onExecuteQuery( sql, (error: any, data: any[]) => {

    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    res.json({
      ok: true,
      showError: data[0].showError,
      data: data[0]
    });

  });

});

VehicleRouter.put('/Using/Vehicle/:pkVehicle', [verifyToken, verifyDriverRole], (req: any, res: Response) => {

  let pkVehicle = req.params.pkVehicle || 0;
  let pkUserToken = req.userData.pkUser || 0;
  let pkDriverToken = req.userData.pkDriver || 0;
  let pkPersonToken = req.userData.pkPerson || 0;

  let sql = `CALL ts_sp_updateUsingVehicle(`;
  sql += `${ pkDriverToken }, `;
  sql += `${ pkVehicle }, `;
  sql += `${ pkPersonToken }, `;
  sql += `${ pkUserToken }, `;
  sql += `'${ reqIp.getClientIp( req ) }'`;
  sql += `);`;

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

VehicleRouter.get('/Usin/Get/:pkDriver', [verifyToken, verifyDriverRole], (req: any, res: Response) => {
  
  let pkDriver = req.params.pkDriver || 0;

  let sql = `CALL ts_sp_getUsingDriver( ${ pkDriver } );`;

  MysqlCon.onExecuteQuery(sql, (error: any, data: any[]) => {
    if (error) {
      return res.status(400).json({
        ok: false,
        error,
      });
    }

    res.json({
      ok: true,
      data: data[0]
    });
    
  });

});

export default VehicleRouter;

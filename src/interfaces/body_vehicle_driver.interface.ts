export interface IBodyVehicleDriver {
  pkVehicle?: number;
  fkDriver: number;
  fkPerson: number;
  fkCategory: number;
  fkBrand: number;
  fkModel: number;
  isProper: number;
  verified: number;
  imgLease: string;
  numberPlate: string;
  year: number;
  color: string;
  imgSoat: string;
  dateSoatExpiration: Date;
  imgPropertyCard: string;
  statusRegister: number;
}

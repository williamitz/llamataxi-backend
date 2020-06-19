export interface IUserSocket {
    pkUser: number;
    userName: string;
    role: string;
    osID?: string;
    device: string;
    room?: string;
    indexHex?: string;
  }

  export interface IUserCoords {
    lat: number;
    lng: number;
  }
  
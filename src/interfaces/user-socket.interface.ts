export interface IUserSocket {
    pkUser: number;
    userName: string;
    nameComplete: string;
    role: string;
    osID?: string;
    device: string;
    room?: string;
    indexHex?: string;
    pkCategory?: number;
    codeCategory?: string;
  }

  export interface IUserCoords {
    lat: number;
    lng: number;
  }
  
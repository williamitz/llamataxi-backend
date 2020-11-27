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
    occupied?: boolean;
    playGeo?: boolean;
  }

  export interface IUserCoords {
    lat: number;
    lng: number;
    codeCategory?: string;
    pkService?: number;
  }

  export interface IConfigOs {
    osId: string;
  }
  
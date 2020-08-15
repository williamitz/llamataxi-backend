import { IBodyService, ICoords } from './body_service.interface';
export interface IWatchGeo {
    lat: number;
    lng: number;
    pkClient: number;
    distanceText: string;
    minutesText: string;
    distance: number;
    minutes: number;
}


export interface IPayloadServiceNew {
    codeCategory: string;
    coords: ICoords,
    data: IBodyService;
}

export interface IPayloadDel {
    pkUser: number;
    msg: string;
}
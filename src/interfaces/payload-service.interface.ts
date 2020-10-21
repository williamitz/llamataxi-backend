import { IBodyService, ICoords } from './body_service.interface';
export interface IWatchGeo {
    lat: number;
    lng: number;
    pkClient: number;
    distanceText: string;
    minutesText: string;
    distance: number;
    minutes: number;
    pkService: number;
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

export interface IPayloadTravel {
    runOrigin: boolean;
    finishOrigin: boolean;
    runDestination: boolean;
    finishDestination: boolean;
    pkClient: number;
    pkService: number;
}


export interface IPayloadChat {
    pkUser: number;
}
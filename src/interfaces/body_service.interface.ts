export interface IBodyService {
    pkService: number;
    fkJournal: number;
    fkRate: number;
    
    coordsOrigin: ICoords;
    coordsDestination: ICoords;
    streetOrigin: string;
    streetDestination: string;

    codeJournal: string;
    distance: number;
    distanceText: string;
    minutes: number;
    minutesText: string;
    rate: number;
}

interface ICoords {
    lat: number;
    lng: number;
}
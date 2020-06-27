export interface IBodyService {
    pkService: number;
    fkJournal: number;
    fkRate: number;
    fkCategory: number;
    
    coordsOrigin: ICoords;
    coordsDestination: ICoords;
    streetOrigin: string;
    streetDestination: string;

    codeJournal: string;
    distance: number;
    distanceText: string;
    minutes: number;
    minutesText: string;
    // rate: number;
    minRatePrc: number;
    isMinRate: boolean;
    paymentType: string;
    rateHistory: number;
    rateService: number;
}

interface ICoords {
    lat: number;
    lng: number;
}

export interface IBodyOffer {
    pkService: number;
    pkOffer: number;
    rateOffer: number;
    isClient: boolean;
    fkDriver: number;
}
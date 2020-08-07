export interface IBodyService {
    pkService: number;
    fkClient: number;
    fkJournal: number;
    fkRate: number;
    fkCategory: number;
    codeCategory: string;
    coordsOrigin: ICoords;
    latOrigin: number;
    lngOrigin: number;
    coordsDestination: ICoords;
    streetOrigin: string;
    streetDestination: string;

    codeJournal: string;
    distance: number;
    distanceText: string;
    minutes: number;
    minutesText: string;
    rateHistory: number;
    rateService: number;
    rateOfferHistory: number;
    rateOffer: number;
    minRate: number;
    minRatePercent: number;
    isMinRate: boolean;
    paymentType: string;
    indexHex: string;

    // datos de relleno para que el conductor identifique al cliente
    img: string;
    nameComplete: string;
    // otros
    created: any;
    osId: string;
    aliasCategory: string;
    changeRate: boolean;
    pkOfferService: number;
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
    fkVehicle: number;
}
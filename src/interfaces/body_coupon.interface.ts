export interface ICoupon {
    pkCoupon: number;
    codeCoupon: string;
    title: string;
    description: string;
    minRateService: number;
    amountCoupon: number;
    dateExpiration: string;
    daysExpiration: number;
    role: string;
}
export default interface IBodyLiqu {
    pkLiquidation: number;
    fkJournalDriver: number;
    fkDriver: number;
    operation: string;
    observation: string;
    amountCompany: number;
    haveDebt: boolean;
    fkAccount: number;
    totalDebt: number;
    totalPay: number;
    totalLiquidation: number;
    paidOut: boolean;
}

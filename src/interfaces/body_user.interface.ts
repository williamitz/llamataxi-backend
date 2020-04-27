export interface IBodyUser {
    pkUser?: number;
    fkTypeDocument: number;
    fkNationality: number;

    name: string;
    surname: string;
    document: string;
    email: string;
    phone: string;
    sex: string;
    img?: string;
    google: boolean;

    userName: string;
    userPassword: string;
    userPassRepit: string;
}
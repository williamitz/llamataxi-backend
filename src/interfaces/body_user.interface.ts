export interface IBodyUser {
    pkUser?: number;
    fkTypeDocument: number;
    fkNationality?: number;

    name: string;
    surname: string;
    document: string;
    brithDate: string;
    email?: string;
    phone?: string;
    sex?: string;
    img?: string;
    role: string;
    google?: boolean;

    verifyReniec?: boolean;

    userName?: string;
    userPassword?: string;
    userPassRepit?: string;

    // registro de conductor

    dateLicenseExpiration?: string;
    isEmployee?: boolean;
    color?: string;
    dateSoatExpiration?: string;
    isProper?: boolean;
    numberPlate?: string;
    year?: number;
}
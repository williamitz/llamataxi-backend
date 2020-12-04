export interface IBodyUser {
    pkUser?: number;
    pkPerson?: number;
    pkDriver: number;
    fkTypeDocument: number;
    fkNationality?: number;

    name: string;
    surname: string;
    document: string;
    dateBirth: string;
    codeReferal: string;
    birthDate?: string;
    brithDate?: string;
    email?: string;
    phone?: string;
    sex?: string;
    img?: string;
    role: string;
    google?: boolean;
    prefixPhone?: string;

    verifyReniec?: boolean;

    userName?: string;
    userPassword?: string;
    userPassRepit?: string;
    conditions?: boolean;

    // registro de conductor

    dateLicenseExpiration?: string;
    isEmployee?: boolean;
    color?: string;
    dateSoatExpiration?: string;
    isProper?: boolean;
    numberPlate?: string;
    year?: number;
}

export interface IUserProfile {
    pkUser: number;
    fkTypeDocument: number;
    document: string;
}

export interface IPassword {
    passwordOld: string;
    password: string;
    passRepit: string;
}

export interface IPasswordWeb {
    pkUser: number;
    nameComplete: string;
    password: string;
}
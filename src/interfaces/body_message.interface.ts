export interface IMessage {
    pkMessage: number;
    fkUserEmisor: number;
    fkUserReceptor: number;
    subject: string;
    message: string;
    tags: string;
    isDriver?: boolean;
}
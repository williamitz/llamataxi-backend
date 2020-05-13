export interface IMessage {
    fkUserEmisor: number;
    fkUserReceptor: number;
    subject: string;
    message: string;
    tags: string;
}
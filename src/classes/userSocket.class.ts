export class UserSocket {
    public id: string;
    public pkUser: number;
    public role: string;
    public userName: string;
    public timer: number;
    public device: string;
    public osID: string;
    public room: string;

    constructor( id: string ) {
        this.id = id;
        this.pkUser = 0;
        this.role = '';
        this.userName = '';
        this.timer = 0;
        this.device = '';
        this.osID = '';
        this.room = '';
    }

}
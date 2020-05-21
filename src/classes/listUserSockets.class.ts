import { UserSocket } from "./userSocket.class";

export class ListUserSockets {
    
    private listUser: UserSocket[] = [];
    private static _instance: ListUserSockets;

    constructor() {}

    public static get instance() {
        return this._instance || ( this._instance = new this() );
    }

    onGetUsers() {
        return this.listUser;
    }

    onAddUser( id: string ) {
        this.listUser.push( new UserSocket( id ) );
    }

    onDeleteUser( id: string ): UserSocket {
        const finded = this.listUser.find( user => user.id === id );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return{id: '', userName: 'undefinde', role: '', pkUser: 0, timer: 0, device: '', osID: ''};
        }

        this.listUser = this.listUser.filter( user => user.id !== id );
        return finded;
    }

    onSingUser( id: string, pkUser: number, userName: string, role: string, device: string, osID = '' ): boolean {
        // const findUser = this.listUser.find( user => user.pkUser === pkUser );
        // if (findUser) {
        //     console.error('Ya existe un usuario configurado con este pk');
        //     return false;
        // }
        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }
        
        finded.pkUser = pkUser,
        finded.role = role;
        finded.userName = userName;
        finded.timer = new Date().getTime();
        finded.device = device;
        finded.osID = osID;
        
        return true;
    }

    onGetAdminSort() {
        let usersAdmin = this.listUser.filter( user => user.role === 'ADMIN_ROLE' );
        
        if (usersAdmin.length === 0) {
            return null;
        }

        if (usersAdmin.length === 1) {
            return usersAdmin[0];
        }
        
        for (let i = 0; i < usersAdmin.length - 2; i++) {
            
            const useri = usersAdmin[i];

            for (let j = i + 1; j < usersAdmin.length - 1; j++) {

                const userj = usersAdmin[j];

                if (useri.timer > userj.timer) {
                    usersAdmin = usersAdmin.filter( user => user.id !== userj.id );
                    usersAdmin.unshift( userj );
                }
                
            }
            
        }

        return usersAdmin[0];

    }


}
import { UserSocket } from './userSocket.class';

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

    onGetDriverHex( indexHex: string ): UserSocket[] {
        return this.listUser.filter( user => user.pkUser !== 0 && user.role === 'DRIVER_ROLE' && user.indexHex === indexHex );
    }

    onAddUser( id: string ) {
        this.listUser.push( new UserSocket( id ) );
    }

    onDeleteUser( id: string ): UserSocket {
        const finded = this.listUser.find( user => user.id === id );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return{
                id: '',
                userName: 'undefined', 
                role: '', 
                pkUser: 0, 
                timer: 0, 
                device: '', 
                osID: '', 
                indexHex: '',
                pkCategory: 0,
                category: '',
                coords: {lat: 0, lng: 0},
                onUpdateCoords() { return ''; },
                onUpdateCategory() { return false }
            };
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

    onLogoutUser(id: string) {
        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }
        
        finded.pkUser = 0,
        finded.role = '';
        finded.userName = '';
        finded.timer = 0;
        finded.device = '';
        finded.osID = '';
        
        return true;
    }

    onGetAdminSort( role: string ) {
        let usersAdmin = this.listUser.filter( user => user.role === role );
        let newArr: UserSocket[] = [];
        let idsArr: number[] = [];
        usersAdmin.forEach( u => {
            if (!idsArr.includes( u.pkUser )) {
                newArr.push(u);
            }
        });

        if (usersAdmin.length === 0) {
            return null;
        }

        if (newArr.length === 1) {
            return newArr[0];
        }

        
        for (let i = 0; i < newArr.length - 2; i++) {
            
            const useri = newArr[i];

            for (let j = i + 1; j < newArr.length - 1; j++) {

                const userj = newArr[j];

                if (useri.timer > userj.timer) {
                    newArr = newArr.filter( user => user.id !== userj.id );
                    newArr.unshift( userj );
                }
                
            }
            
        }

        return newArr[0];

    }

    onFindUser( id: string ): UserSocket {
        const finded =  this.listUser.find( u => u.id === id );
        if (!finded) {
            return{
                id: '',
                userName: 'undefined', 
                role: '', 
                pkUser: 0, 
                timer: 0, 
                device: '', 
                osID: '', 
                indexHex: '',
                pkCategory: 0,
                category: '',
                coords: {lat: 0, lng: 0},
                onUpdateCoords() { return ''; },
                onUpdateCategory() { return false }
            };
        }

        return finded;
    }

    onFindDriversHexCategory( category: string, hex: string ): UserSocket[] {
        return this.listUser.filter( user => user.role === 'DRIVER_ROLE' && user.category === category && user.indexHex === hex );
    }

    onUpdateTime( id: string ) {
        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }

        finded.timer = new Date().getTime();
        return true;
    }
}
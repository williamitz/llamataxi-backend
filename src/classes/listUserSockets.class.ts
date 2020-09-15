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
                nameComplete: '',
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
                occupied: false,
                playGeo: false
                // onUpdateCategory() { return false }
            };
        }

        if (finded.pkUser === 0) {
            this.listUser = this.listUser.filter( user => user.id !== id );
        }

        return finded;
    }

    onSingUser( id: string, pkUser: number, userName: string, nameComplete: string, role: string, device: string, osID = '', pkCategory = 0, codeCategory = 'no especificado', occupied = false ): boolean {

        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }
        
        const userRepit = this.listUser.filter( (user) => user.pkUser === pkUser && user.id !== id );

        if (userRepit.length > 0) {

            userRepit.forEach( (item) => {
                this.listUser = this.listUser.filter( us => us.id !== item.id );
            });
        }
        
        finded.pkUser = pkUser,
        finded.role = role;
        finded.userName = userName;
        finded.nameComplete = nameComplete;
        finded.timer = new Date().getTime();
        finded.device = device;
        finded.osID = osID;
        finded.pkCategory = pkCategory;
        finded.category = codeCategory;
        finded.occupied = occupied;
        return true;
    }

    onLogoutUser(id: string, pkUser: number) {
        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }
        
        // if (pkUser !== 0) {            
        //     this.listUser = this.listUser.filter( user => user.pkUser !== pkUser && user.id !== id );
        // }
        
        finded.pkUser = 0,
        finded.role = '';
        finded.userName = '';
        finded.nameComplete = '';
        finded.timer = 0;
        finded.device = '';
        finded.osID = '';
        finded.occupied = false;
        
        return true;
    }

    onChangePlayGeo( id: string, value: boolean ) {
        const finded = this.listUser.find( user => user.id === id  );
        if (!finded) {
            console.error('No se encontró usuario socket');
            return false;
        }

        finded.playGeo = value;
        
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
                nameComplete: '',
                role: '', 
                pkUser: 0, 
                timer: 0, 
                device: '', 
                osID: '', 
                indexHex: '',
                pkCategory: 0,
                category: '',
                coords: {lat: 0, lng: 0},
                occupied: false,
                onUpdateCoords() { return ''; },
                playGeo: false
                // onUpdateCategory() { return false }
            };
        }

        return finded;
    }

    onChangeOccupierd( pk: number, occupied: boolean ){
        const findeed = this.listUser.filter( uss => uss.pkUser === pk && uss.role === 'DRIVER_ROLE');
        findeed.forEach( item => {
            item.occupied = occupied;
        });

        return true;
    }

    onFindUserForPk( pk: number ): UserSocket {
        const finded =  this.listUser.find( u => u.pkUser === pk );
        // console.log('list user', finded);
        if (!finded) {
            return{
                id: '',
                userName: 'undefined',
                nameComplete: '',
                role: '', 
                pkUser: 0, 
                timer: 0, 
                device: '', 
                osID: '', 
                indexHex: '',
                pkCategory: 0,
                category: '',
                coords: {lat: 0, lng: 0},
                occupied: false,
                onUpdateCoords() { return ''; },
                playGeo: false
                // onUpdateCategory() { return false }
            };
        }

        return finded;
    }

    onFindDriversHex( hex: string ): UserSocket[] {
        // && user.category === category 
        return this.listUser.filter( user => user.role === 'DRIVER_ROLE' && user.indexHex === hex && user.occupied === false && user.playGeo === true );
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
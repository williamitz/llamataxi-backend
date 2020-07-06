import { ICoords } from '../interfaces/coords.interface';
import h3 from 'h3-js';
export class UserSocket {
    public id: string;
    public pkUser: number;
    public role: string;
    public userName: string;
    public nameComplete: string;
    public timer: number;
    public device: string;
    public osID: string;
    public indexHex: string;
    public pkCategory: number;
    public category: string;
    public coords: ICoords;
    public occupied: boolean;

    constructor( id: string ) {
        this.id = id;
        this.pkUser = 0;
        this.role = '';
        this.userName = '';
        this.nameComplete = '';
        this.timer = 0;
        this.device = '';
        this.osID = '';
        this.indexHex = '';
        this.pkCategory = 0;
        this.category = 'No especificado';
        this.coords = { lat: 0, lng: 0 };
        this.occupied = false;
    }

    onUpdateCoords( lat: number, lng: number, radiusPentagon: number ): string{
        
        this.coords.lat = lat;
        this.coords.lng = lng;
        this.indexHex = h3.geoToH3( lat, lng, radiusPentagon );
        return this.indexHex;
    }

    // onUpdateCategory( pkCategory: number, nameCategory: string ): boolean {
    //     this.pkCategory = pkCategory;
    //     this.category = nameCategory
    //     return true;
    // }

}
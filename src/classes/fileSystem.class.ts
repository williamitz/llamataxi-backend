import path from 'path';
import fs from 'fs';

export default class FileSystem {
    
    constructor() {}

    public static buildPathDriver( pkDriver: number ): string {
        let pathDriver = path.resolve( __dirname, '../upload/driver/', `${ pkDriver }` );

        if (!fs.existsSync(pathDriver)) {
            fs.mkdirSync( pathDriver );
        }
 
        return pathDriver;
    }

    public static buildPathVehicle( pkDriver: number, pkVehicle: number ): string {
        
        this.buildPathDriver( pkDriver );
        let pathVehicle = path.resolve( __dirname, `../upload/driver/${pkDriver}/vehicle-${pkVehicle}` );

        if (!fs.existsSync(pathVehicle)) {
            fs.mkdirSync( pathVehicle );
        }

        return pathVehicle;
    }
}
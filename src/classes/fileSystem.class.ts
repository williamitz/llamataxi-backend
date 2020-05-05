import path from 'path';
import fs from 'fs';

export default class FileSystem {
    constructor() {}

    public static buildPathDriver( idUser: number ): string {
        let pathDriver = path.resolve( __dirname, '../upload/driver', `${ idUser }` );

        if (!fs.existsSync(pathDriver)) {
            fs.mkdirSync( pathDriver );
        }

        return pathDriver;
    }
}
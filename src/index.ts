import { ENCRYPT_KEY } from './global/environments.global';
import bodyParser from 'body-parser';
import cors from 'cors';
import MainRouter from './routes/main.route';
import MainServer from './classes/mainServer.class';
const server = MainServer.instance;
import  bcrypt from 'bcrypt';
// import h3 from 'h3-js';
// const cryptr = new Cryptr(ENCRYPT_KEY);

// parse application/x-www-form-urlencoded
server.app.use( bodyParser.urlencoded({ extended: false }) );

// parse json
server.app.use( bodyParser.json() );

// config cors
server.app.use( cors({ credentials: true, origin: true  }) );

server.app.use( MainRouter );

server.onRun( (error: any) => {

    if (error) return console.log('Error al levantar servidor, revise dependencias  :(');

    console.log(`Servidor corriendo en puerto : ${ server.port }`);
    setTimeout(() => {
        server.loadJournal();
        // server.loadPercentRate();
    }, 2000);
    
    let codeVerify = Math.floor( Math.random() * (9999 - 1000) + 1000 );
    console.log('code math', codeVerify);
    // const arrChildren: any[] = h3.kRing( '878e62cecffffff' , 7);
    // const plygons: any = [];

    // arrChildren.forEach( iChildren => {
    //     // extraemos las coordenadas de los vértices del polígono
    //     let polygon = h3.h3ToGeoBoundary( iChildren, false );
    //     // extraemos las coordenadas del centro del polígono
    //     let center = h3.h3ToGeo( iChildren );
    //     plygons.push( {polygon, center} );
    //     console.log('aristas', polygon);
    // });
    // console.log('Vecinos de un centro dado kring', arrChildren);
    // console.log('Polygonos', plygons);
});

// console.log('clave', bcrypt.hashSync('Gamaniel1', 10));
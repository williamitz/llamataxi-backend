import { ENCRYPT_KEY } from './global/environments.global';
import bodyParser from 'body-parser';
import cors from 'cors';
import MainRouter from './routes/main.route';
import MainServer from './classes/mainServer.class';
import MysqlClass from './classes/mysqlConnect.class';
const server = MainServer.instance;
import  Cryptr from 'cryptr';
// import h3 from 'h3-js';
const cryptr = new Cryptr(ENCRYPT_KEY);

// parse application/x-www-form-urlencoded
server.app.use( bodyParser.urlencoded({ extended: false }) );

// parse json
server.app.use( bodyParser.json() );

// config cors
server.app.use( cors({ credentials: true, origin: true  }) );

server.app.use( MainRouter );

// let test = cryptr.encrypt('123');
// console.log(`enciptado`, '123' , '-', cryptr.encrypt('123'));
// console.log(`desenciptado`, '123' , '-', cryptr.decrypt(test));

// console.log('index', h3.geoToH3(-12.08296108245849600000, -77.05254364013672000000, 7));

server.onRun( (error: any) => {

    if (error) return console.log('Error al levantar servidor, revise dependencias  :(');

    console.log(`Servidor corriendo en puerto : ${ server.port }`);
    MysqlClass.instance;
    
});

export const PORT = Number(process.env.PORT) || 3000;

export const SEED_KEY = process.env.SEED_KEY || 'LLAMATAXI-APP-2020';
export const ENCRYPT_KEY = process.env.ENCRYPT_KEY || 'Ll4m4t@x1';

export const HOST_DB = process.env.HOST_DB || 'localhost'; // 'localhost'; // "206.189.182.84"; // 
export const PORT_DB = parseInt(process.env.PORT_DB || '3306'); 
export const USER_DB = process.env.USER_DB || 'root' // 'root'; // 'llamataxi' // 
export const PASSWORD_DB = process.env.PASSWORD_DB || ''; // ''; // "p&DEw4oYjK#V"; // 

export const NAME_DB = process.env.NAME_DB || "llamataxi_db";

// one signal config

export const OS_APP = process.env.OS_APP || '8e919063-5003-4974-b566-b15a1da7eabe';// 'caa68993-c7a5-4a17-bebf-6963ba72519b';
export const OS_KEY = process.env.OS_KEY || 'Basic MGMwMzViY2YtMmJmYi00ZmZmLWJhZGMtNGQxY2EwMDQ2ZGRk'; //  'Basic YTE5MmRjYjQtMjRkZi00Y2Q0LThkZDMtYWY3YjEyNjg0NzRh'; // 


// twilio config

export const TWILIO_ID = process.env.TWILIO_ID || 'ACcdea36ead5a0eb1838ff210943a8816a';
export const TWILIO_TOKEN = process.env.TWILIO_TOKEN || 'cd5e8f1996087d4fd8b9754d26adf40c';
export const TWILIO_PHONE = process.env.TWILIO_PHONE || '+18174407150';

/*
Si pierde su teléfono o no tiene acceso a su dispositivo de verificación, 
este código es su seguridad para acceder a su cuenta. */
// -nAfptxyI4Tz-rwJuFXQ6dSu0BHFE_X3wqAZC2Qw
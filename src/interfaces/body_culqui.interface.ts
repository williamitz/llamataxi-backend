export interface IToken {
    card_number: string;
    cvv: string;
    expiration_month: string;
    expiration_year: string;
    email: string;
    // cardAll: string;
    expiration: string;
}

export interface ICustomer {
    first_name: string;
    last_name: string;
    email: string;
    address: string;
    address_city: string;
    country_code: string;
    phone_number: number;
}

export interface ICard {
    customer_id: string;
    token_id: string;
    validate: boolean;
    // token
    // body_token: IToken;

    // customer 
    // body_customer: ICustomer;
}


// Monto del cargo. Sin punto decimal.
// Ejemplo: 100.00 serían 10000

export interface ICarge {
    amount: number;
    currency_code: string;
    email: string;
    source_id: string;
}

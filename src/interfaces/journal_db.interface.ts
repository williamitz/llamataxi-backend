import { IRateJournal } from "./rateForJournal.interface";

export default interface IJournalDB {
    pkJournal: number;
	nameJournal: string;
    codeJournal: string;
    hourStart: string;
    hourEnd: string;
    rates?: IRateJournal[];
}
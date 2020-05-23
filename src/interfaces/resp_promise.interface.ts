export default interface IResponse {
    ok: boolean;
    error?: any;
    data?: any;
    showError?: number;
    socket?: string;
}

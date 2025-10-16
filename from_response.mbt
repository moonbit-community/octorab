pub trait FromResponse {
    from_response(response : @http.Response) -> Self
}
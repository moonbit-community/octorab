///|
pub enum Auth {
  Token(String)
  Bearer(String)
} derive(Show, Eq, ToJson)

///|
pub fn Auth::token(token : String) -> Auth {
  Token(token)
}

///|
pub fn Auth::bearer(token : String) -> Auth {
  Bearer(token)
}

///|
pub fn Auth::header(self : Auth) -> (String, String) {
  match self {
    Token(token) => ("Authorization", "token \{token}")
    Bearer(token) => ("Authorization", "Bearer \{token}")
  }
}

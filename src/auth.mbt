///|
pub enum Auth {
  Token(String)
  Bearer(String)
} derive(Eq, ToJson)

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

///|
pub impl Show for Auth with fn output(self, logger) {
  match self {
    Token(arg0) => {
      logger.write_string("Token(")
      logger.write_object(arg0)
      logger.write_string(")")
    }
    Bearer(arg0) => {
      logger.write_string("Bearer(")
      logger.write_object(arg0)
      logger.write_string(")")
    }
  }
}

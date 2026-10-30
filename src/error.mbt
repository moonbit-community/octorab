///|
pub struct GitHubError {
  status : Int32
  message : String
  documentation_url : String?
  errors : Array[Json]?
} derive(ToJson, Eq)

///|
pub suberror OctorabError {
  InvalidUrl(String)
  HttpError(GitHubError)
} derive(ToJson)

///|
pub fn is_success_status(code : Int32) -> Bool {
  code >= 200 && code < 300
}

///|
fn parse_error_fields(json : Json) -> (String?, String?, Array[Json]?) {
  match json {
    Json::Object(map) => {
      let mut message : String? = None
      let mut documentation_url : String? = None
      let mut errors : Array[Json]? = None
      if map is { "message": Json::String(msg), .. } {
        message = Some(msg)
      }
      if map is { "documentation_url": Json::String(url), .. } {
        documentation_url = Some(url)
      }
      if map is { "errors": Json::Array(errs), .. } {
        errors = Some(errs)
      }
      (message, documentation_url, errors)
    }
    _ => (None, None, None)
  }
}

///|
pub fn parse_github_error(status : Int32, body : &@io.Data) -> GitHubError {
  let mut message : String = "HTTP \{status}"
  let mut documentation_url : String? = None
  let mut errors : Array[Json]? = None
  try body.json() catch {
    _ => ()
  } noraise {
    json => {
      let (msg, doc_url, err_list) = parse_error_fields(json)
      if msg is Some(msg) {
        message = msg
      }
      if doc_url is Some(url) {
        documentation_url = Some(url)
      }
      if err_list is Some(errs) {
        errors = Some(errs)
      }
    }
  }
  if message == "HTTP \{status}" {
    try body.text() catch {
      _ => ()
    } noraise {
      text => if text != "" { message = text }
    }
  }
  { status, message, documentation_url, errors, }
}

///|
pub impl Show for GitHubError with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("status: ")
  logger.write_object(self.status)
  logger.write_string(", message: ")
  logger.write_object(self.message)
  logger.write_string(", documentation_url: ")
  match self.documentation_url {
    None => logger.write_string("None")
    Some(value387) => {
      logger.write_string("Some(")
      logger.write_object(value387)
      logger.write_string(")")
    }
  }
  logger.write_string(", errors: ")
  match self.errors {
    None => logger.write_string("None")
    Some(value389) => {
      logger.write_string("Some(")
      logger.write_string("[")
      for i390, value390 in value389 {
        if i390 > 0 {
          logger.write_string(", ")
        }
        output_legacy_json(value390, logger)
      }
      logger.write_string("]")
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for OctorabError with fn output(self, logger) {
  match self {
    InvalidUrl(arg0) => {
      logger.write_string("InvalidUrl(")
      logger.write_object(arg0)
      logger.write_string(")")
    }
    HttpError(arg0) => {
      logger.write_string("HttpError(")
      logger.write_object(arg0)
      logger.write_string(")")
    }
  }
}

///|
// Keep the historical public error display format without deprecated Json Show.
fn output_legacy_json(value : Json, logger : &Logger) -> Unit {
  match value {
    Null => logger.write_string("Null")
    True => logger.write_string("True")
    False => logger.write_string("False")
    Number(n, repr~) => {
      logger.write_string("Number(")
      logger.write_object(n)
      if repr is Some(repr) {
        logger.write_string(", repr=Some(")
        logger.write_string(repr)
        logger.write_string(")")
      }
      logger.write_string(")")
    }
    String(s) => {
      logger.write_string("String(")
      logger.write_string(s)
      logger.write_string(")")
    }
    Array(values) => {
      logger.write_string("Array([")
      for i, item in values {
        if i > 0 {
          logger.write_string(", ")
        }
        output_legacy_json(item, logger)
      }
      logger.write_string("])")
    }
    Object(values) => {
      logger.write_string("Object({")
      let mut first = true
      for key, item in values {
        if !first {
          logger.write_string(", ")
        }
        first = false
        logger.write_string(key)
        logger.write_string(": ")
        output_legacy_json(item, logger)
      }
      logger.write_string("})")
    }
  }
}

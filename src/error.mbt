///|
pub struct GitHubError {
  status : Int
  message : String
  documentation_url : String?
  errors : Array[Json]?
} derive(Show, ToJson, Eq)

///|
pub suberror OctorabError {
  InvalidUrl(String)
  HttpError(GitHubError)
} derive(Show, ToJson)

///|
pub fn is_success_status(code : Int) -> Bool {
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
pub fn parse_github_error(status : Int, body : &@io.Data) -> GitHubError {
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
  { status, message, documentation_url, errors }
}

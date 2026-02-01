///|
pub async fn Octorab::render_markdown(
  self : Octorab,
  text : String,
  mode? : String,
  context? : String,
) -> String {
  let payload : Map[String, Json] = {}
  payload["text"] = Json::string(text)
  if mode is Some(mode) {
    payload["mode"] = Json::string(mode)
  }
  if context is Some(context) {
    payload["context"] = Json::string(context)
  }
  let headers : Map[String, String] = { "Content-Type": "application/json" }
  let (_response, body) = self.request_raw(
    @http.RequestMethod::Post,
    "/markdown",
    body=Json::object(payload),
    headers~,
  )
  body.text()
}

///|
pub async fn Octorab::render_markdown_raw(
  self : Octorab,
  text : String,
) -> String {
  let headers : Map[String, String] = { "Content-Type": "text/plain" }
  let (_response, body) = self.request_raw(
    @http.RequestMethod::Post,
    "/markdown/raw",
    body=text,
    headers~,
  )
  body.text()
}

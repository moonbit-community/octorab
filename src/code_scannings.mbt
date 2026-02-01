///|
pub struct CodeScanningsHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::code_scannings(
  self : Octorab,
  owner : String,
  repo : String,
) -> CodeScanningsHandler {
  { crab: self, owner, repo }
}

///|
pub async fn CodeScanningsHandler::get(
  self : CodeScanningsHandler,
  alert_number : Int,
) -> Json {
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/code-scanning/alerts/\{alert_number}",
  )
}

///|
pub async fn CodeScanningsHandler::list(
  self : CodeScanningsHandler,
  state? : String,
  severity? : String,
  tool_name? : String,
  tool_guid? : String,
  reference? : String,
  sort? : String,
  direction? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "state", state)
  add_query(params, "severity", severity)
  add_query(params, "tool_name", tool_name)
  add_query(params, "tool_guid", tool_guid)
  add_query(params, "ref", reference)
  add_query(params, "sort", sort)
  add_query(params, "direction", direction)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/code-scanning/alerts",
    query=params,
  )
}

///|
pub async fn CodeScanningsHandler::update(
  self : CodeScanningsHandler,
  alert_number : Int,
  state? : String,
  dismissed_reason? : String,
  dismissed_comment? : String,
) -> Json {
  let payload : Map[String, Json] = {}
  if state is Some(value) {
    payload["state"] = Json::string(value)
  }
  if dismissed_reason is Some(value) {
    payload["dismissed_reason"] = Json::string(value)
  }
  if dismissed_comment is Some(value) {
    payload["dismissed_comment"] = Json::string(value)
  }
  let body = Json::object(payload)
  self.crab.patch(
    "/repos/\{self.owner}/\{self.repo}/code-scanning/alerts/\{alert_number}",
    body,
  )
}

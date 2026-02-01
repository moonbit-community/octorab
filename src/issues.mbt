///|
pub struct IssuesHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::issues(
  self : Octorab,
  owner : String,
  repo : String,
) -> IssuesHandler {
  { crab: self, owner, repo }
}

///|
pub async fn IssuesHandler::get(self : IssuesHandler, number : Int) -> Issue {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/issues/\{number}")
}

///|
pub async fn IssuesHandler::list(
  self : IssuesHandler,
  state? : IssueState,
  labels? : Array[String],
  per_page? : Int,
  page? : Int,
  creator? : String,
  assignee? : String,
  since? : String,
) -> Page[Issue] {
  let params : Map[String, String] = {}
  if state is Some(state) {
    add_query(params, "state", Some(state.as_query()))
  }
  if labels is Some(labels) {
    add_query(params, "labels", Some(labels.join(",")))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  add_query(params, "creator", creator)
  add_query(params, "assignee", assignee)
  add_query(params, "since", since)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/issues", query=params)
}

///|
pub async fn IssuesHandler::create(
  self : IssuesHandler,
  title : String,
  body? : String,
  assignee? : String,
  labels? : Array[String],
) -> Issue {
  let payload : Map[String, Json] = {}
  payload["title"] = Json::string(title)
  if body is Some(text) {
    payload["body"] = Json::string(text)
  }
  if assignee is Some(name) {
    payload["assignee"] = Json::string(name)
  }
  if labels is Some(labels) {
    let json_labels = labels.map(Json::string)
    payload["labels"] = Json::array(json_labels)
  }
  let body_json = Json::object(payload)
  self.crab.post("/repos/\{self.owner}/\{self.repo}/issues", body_json)
}

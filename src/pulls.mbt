///|
pub struct PullsHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::pulls(
  self : Octorab,
  owner : String,
  repo : String,
) -> PullsHandler {
  { crab: self, owner, repo }
}

///|
pub async fn PullsHandler::get(
  self : PullsHandler,
  number : Int,
) -> PullRequest {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/pulls/\{number}")
}

///|
pub async fn PullsHandler::list(
  self : PullsHandler,
  state? : IssueState,
  head? : String,
  base? : String,
  sort? : PullSort,
  direction? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[PullRequest] {
  let params : Map[String, String] = {}
  if state is Some(state) {
    add_query(params, "state", Some(state.as_query()))
  }
  add_query(params, "head", head)
  add_query(params, "base", base)
  if sort is Some(sort) {
    add_query(params, "sort", Some(sort.as_query()))
  }
  if direction is Some(direction) {
    add_query(params, "direction", Some(direction.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/pulls", query=params)
}

///|
pub async fn PullsHandler::list_files(
  self : PullsHandler,
  number : Int,
  per_page? : Int,
  page? : Int,
) -> Page[PullRequestFile] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/pulls/\{number}/files",
    query=params,
  )
}

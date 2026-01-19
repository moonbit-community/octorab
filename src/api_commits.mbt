///|
pub struct CommitsHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::commits(
  self : Octorab,
  owner : String,
  repo : String,
) -> CommitsHandler {
  { crab: self, owner, repo }
}

///|
pub async fn CommitsHandler::get(self : CommitsHandler, sha : String) -> Json {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/commits/\{sha}")
}

///|
pub async fn CommitsHandler::list(
  self : CommitsHandler,
  sha? : String,
  path? : String,
  author? : String,
  since? : String,
  until? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "sha", sha)
  add_query(params, "path", path)
  add_query(params, "author", author)
  add_query(params, "since", since)
  add_query(params, "until", until)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/commits", query=params)
}

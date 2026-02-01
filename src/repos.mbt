///|
pub struct ReposHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::repos(
  self : Octorab,
  owner : String,
  repo : String,
) -> ReposHandler {
  { crab: self, owner, repo }
}

///|
pub async fn ReposHandler::get(self : ReposHandler) -> Repository {
  self.crab.get("/repos/\{self.owner}/\{self.repo}")
}

///|
pub fn ReposHandler::issues(self : ReposHandler) -> IssuesHandler {
  self.crab.issues(self.owner, self.repo)
}

///|
pub fn ReposHandler::pulls(self : ReposHandler) -> PullsHandler {
  self.crab.pulls(self.owner, self.repo)
}

///|
pub fn ReposHandler::commits(self : ReposHandler) -> CommitsHandler {
  self.crab.commits(self.owner, self.repo)
}

///|
pub async fn ReposHandler::list_branches(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/branches", query=params)
}

///|
pub async fn ReposHandler::list_tags(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/tags", query=params)
}

///|
pub async fn ReposHandler::list_contributors(
  self : ReposHandler,
  anon? : Bool,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_bool(params, "anon", anon)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/contributors",
    query=params,
  )
}

///|
pub async fn ReposHandler::list_languages(self : ReposHandler) -> Json {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/languages")
}

///|
pub async fn ReposHandler::list_forks(
  self : ReposHandler,
  sort? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  add_query(params, "sort", sort)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/forks", query=params)
}

///|
pub async fn ReposHandler::list_releases(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/releases", query=params)
}

///|
pub async fn ReposHandler::get_release(
  self : ReposHandler,
  release_id : Int,
) -> Json {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/releases/\{release_id}")
}

///|
pub async fn ReposHandler::list_stargazers(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/stargazers",
    query=params,
  )
}

///|
pub async fn ReposHandler::list_watchers(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/subscribers",
    query=params,
  )
}

///|
pub async fn ReposHandler::list_events(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/events", query=params)
}

///|
pub async fn ReposHandler::list_teams(
  self : ReposHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/repos/\{self.owner}/\{self.repo}/teams", query=params)
}

///|
pub async fn ReposHandler::get_contents(
  self : ReposHandler,
  path? : String,
  ref_name? : String,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "ref", ref_name)
  let full_path = match path {
    Some(p) => "/repos/\{self.owner}/\{self.repo}/contents/\{p}"
    None => "/repos/\{self.owner}/\{self.repo}/contents"
  }
  self.crab.get(full_path, query=params)
}

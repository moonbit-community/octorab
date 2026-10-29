///|
pub struct TeamsHandler {
  crab : Octorab
  org : String
}

///|
pub fn Octorab::teams(self : Octorab, org : String) -> TeamsHandler {
  { crab: self, org, }
}

///|
pub async fn TeamsHandler::list(
  self : TeamsHandler,
  per_page? : Int32,
  page? : Int32,
) -> Page[Json] {
  let params : Map[String, String] = Map([])
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/orgs/\{self.org}/teams", query=params)
}

///|
pub async fn TeamsHandler::get(self : TeamsHandler, team_slug : String) -> Json {
  self.crab.get("/orgs/\{self.org}/teams/\{team_slug}")
}

///|
pub async fn TeamsHandler::list_repos(
  self : TeamsHandler,
  team_slug : String,
  per_page? : Int32,
  page? : Int32,
) -> Page[Repository] {
  let params : Map[String, String] = Map([])
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/orgs/\{self.org}/teams/\{team_slug}/repos", query=params)
}

///|
pub async fn TeamsHandler::list_members(
  self : TeamsHandler,
  team_slug : String,
  per_page? : Int32,
  page? : Int32,
) -> Page[User] {
  let params : Map[String, String] = Map([])
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/orgs/\{self.org}/teams/\{team_slug}/members",
    query=params,
  )
}

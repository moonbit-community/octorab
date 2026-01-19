///|
pub struct AppsHandler {
  crab : Octorab
}

///|
pub fn Octorab::apps(self : Octorab) -> AppsHandler {
  { crab: self }
}

///|
pub async fn AppsHandler::installation(
  self : AppsHandler,
  installation_id : Int,
) -> Json {
  self.crab.get("/app/installations/\{installation_id}")
}

///|
pub async fn AppsHandler::list_installations(
  self : AppsHandler,
  since? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "since", since)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/app/installations", query=params)
}

///|
pub async fn AppsHandler::get_repository_installation(
  self : AppsHandler,
  owner : String,
  repo : String,
) -> Json {
  self.crab.get("/repos/\{owner}/\{repo}/installation")
}

///|
pub async fn AppsHandler::get_org_installation(
  self : AppsHandler,
  org : String,
) -> Json {
  self.crab.get("/orgs/\{org}/installation")
}

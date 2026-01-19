///|
pub struct CurrentHandler {
  crab : Octorab
}

///|
pub fn Octorab::current(self : Octorab) -> CurrentHandler {
  { crab: self }
}

///|
pub async fn CurrentHandler::user(self : CurrentHandler) -> User {
  self.crab.get("/user")
}

///|
pub async fn CurrentHandler::app(self : CurrentHandler) -> Json {
  self.crab.get("/app")
}

///|
pub async fn CurrentHandler::update_user(
  self : CurrentHandler,
  data : Json,
) -> User {
  self.crab.patch("/user", data)
}

///|
pub async fn CurrentHandler::list_repos_starred(
  self : CurrentHandler,
  sort? : String,
  direction? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  add_query(params, "sort", sort)
  if direction is Some(value) {
    add_query(params, "direction", Some(value.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/user/starred", query=params)
}

///|
pub async fn CurrentHandler::list_repos(
  self : CurrentHandler,
  visibility? : String,
  affiliation? : String,
  type_? : String,
  sort? : String,
  direction? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  add_query(params, "visibility", visibility)
  add_query(params, "affiliation", affiliation)
  add_query(params, "type", type_)
  add_query(params, "sort", sort)
  if direction is Some(value) {
    add_query(params, "direction", Some(value.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/user/repos", query=params)
}

///|
pub async fn CurrentHandler::list_gists(
  self : CurrentHandler,
  since? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "since", since)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/gists", query=params)
}

///|
pub async fn CurrentHandler::list_starred_gists(
  self : CurrentHandler,
  since? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "since", since)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/gists/starred", query=params)
}

///|
pub async fn CurrentHandler::list_app_installations(
  self : CurrentHandler,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get("/user/installations", query=params)
}

///|
pub async fn CurrentHandler::list_org_memberships(
  self : CurrentHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/user/memberships/orgs", query=params)
}

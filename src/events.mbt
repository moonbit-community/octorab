///|
pub async fn Octorab::events(
  self : Octorab,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/events", query=params)
}

///|
pub async fn Octorab::repo_events(
  self : Octorab,
  owner : String,
  repo : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/repos/\{owner}/\{repo}/events", query=params)
}

///|
pub async fn Octorab::org_events(
  self : Octorab,
  org : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/orgs/\{org}/events", query=params)
}

///|
pub async fn Octorab::user_events(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/users/\{username}/events", query=params)
}

///|
pub async fn Octorab::user_received_events(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/users/\{username}/received_events", query=params)
}

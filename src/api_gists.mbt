///|
pub struct GistsHandler {
  crab : Octorab
}

///|
pub fn Octorab::gists(self : Octorab) -> GistsHandler {
  { crab: self }
}

///|
pub async fn GistsHandler::get(self : GistsHandler, gist_id : String) -> Json {
  self.crab.get("/gists/\{gist_id}")
}

///|
pub async fn GistsHandler::list(
  self : GistsHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/gists", query=params)
}

///|
pub async fn GistsHandler::list_public(
  self : GistsHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/gists/public", query=params)
}

///|
pub async fn GistsHandler::list_starred(
  self : GistsHandler,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/gists/starred", query=params)
}

///|
pub async fn GistsHandler::list_for_user(
  self : GistsHandler,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/users/\{username}/gists", query=params)
}

///|
pub async fn GistsHandler::create(self : GistsHandler, body : Json) -> Json {
  self.crab.post("/gists", body)
}

///|
pub async fn GistsHandler::delete(
  self : GistsHandler,
  gist_id : String,
) -> Unit {
  let _ = self.crab.delete("/gists/\{gist_id}")
  ()
}

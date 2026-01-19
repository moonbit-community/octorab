///|
pub struct ChecksHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::checks(
  self : Octorab,
  owner : String,
  repo : String,
) -> ChecksHandler {
  { crab: self, owner, repo }
}

///|
pub async fn ChecksHandler::get(
  self : ChecksHandler,
  check_run_id : Int,
) -> Json {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/check-runs/\{check_run_id}")
}

///|
pub async fn ChecksHandler::list_for_ref(
  self : ChecksHandler,
  ref_name : String,
  check_name? : String,
  status? : String,
  filter? : String,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "check_name", check_name)
  add_query(params, "status", status)
  add_query(params, "filter", filter)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/commits/\{ref_name}/check-runs",
    query=params,
  )
}

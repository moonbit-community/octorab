///|
pub async fn Octorab::notifications(
  self : Octorab,
  all? : Bool,
  participating? : Bool,
  since? : String,
  before? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_bool(params, "all", all)
  add_query_bool(params, "participating", participating)
  add_query(params, "since", since)
  add_query(params, "before", before)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/notifications", query=params)
}

///|
pub async fn Octorab::repo_notifications(
  self : Octorab,
  owner : String,
  repo : String,
  all? : Bool,
  participating? : Bool,
  since? : String,
  before? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_bool(params, "all", all)
  add_query_bool(params, "participating", participating)
  add_query(params, "since", since)
  add_query(params, "before", before)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/repos/\{owner}/\{repo}/notifications", query=params)
}

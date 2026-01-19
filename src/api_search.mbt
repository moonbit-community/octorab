///|
pub async fn Octorab::search_repositories(
  self : Octorab,
  query : String,
  sort? : RepoSort,
  order? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  params["q"] = query
  if sort is Some(sort) {
    add_query(params, "sort", Some(sort.as_query()))
  }
  if order is Some(order) {
    add_query(params, "order", Some(order.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/search/repositories", query=params)
}

///|
pub async fn Octorab::search_issues(
  self : Octorab,
  query : String,
  sort? : PullSort,
  order? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  params["q"] = query
  if sort is Some(sort) {
    add_query(params, "sort", Some(sort.as_query()))
  }
  if order is Some(order) {
    add_query(params, "order", Some(order.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/search/issues", query=params)
}

///|
pub async fn Octorab::search_code(
  self : Octorab,
  query : String,
  sort? : String,
  order? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  params["q"] = query
  add_query(params, "sort", sort)
  if order is Some(order) {
    add_query(params, "order", Some(order.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/search/code", query=params)
}

///|
pub async fn Octorab::search_users(
  self : Octorab,
  query : String,
  sort? : String,
  order? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  params["q"] = query
  add_query(params, "sort", sort)
  if order is Some(order) {
    add_query(params, "order", Some(order.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/search/users", query=params)
}

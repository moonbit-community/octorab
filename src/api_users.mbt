///|
pub async fn Octorab::user(self : Octorab, username : String) -> User {
  self.get("/users/\{username}")
}

///|
pub async fn Octorab::current_user(self : Octorab) -> User {
  self.get("/user")
}

///|
pub async fn Octorab::current_user_orgs(
  self : Octorab,
  per_page? : Int,
  page? : Int,
) -> Page[Organization] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/user/orgs", query=params)
}

///|
pub async fn Octorab::list_user_repos(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
  sort? : String,
  direction? : SortDirection,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  add_query(params, "sort", sort)
  if direction is Some(dir) {
    add_query(params, "direction", Some(dir.as_query()))
  }
  self.get_page("/users/\{username}/repos", query=params)
}

///|
pub async fn Octorab::list_org_repos(
  self : Octorab,
  org : String,
  per_page? : Int,
  page? : Int,
  sort? : String,
  direction? : SortDirection,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  add_query(params, "sort", sort)
  if direction is Some(dir) {
    add_query(params, "direction", Some(dir.as_query()))
  }
  self.get_page("/orgs/\{org}/repos", query=params)
}

///|
pub async fn Octorab::list_user_followers(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/users/\{username}/followers", query=params)
}

///|
pub async fn Octorab::list_user_following(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/users/\{username}/following", query=params)
}

///|
pub async fn Octorab::list_user_orgs(
  self : Octorab,
  username : String,
  per_page? : Int,
  page? : Int,
) -> Page[Organization] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page("/users/\{username}/orgs", query=params)
}

///|
pub struct OrgsHandler {
  crab : Octorab
  org : String
}

///|
pub fn Octorab::orgs(self : Octorab, org : String) -> OrgsHandler {
  { crab: self, org }
}

///|
pub async fn OrgsHandler::get(self : OrgsHandler) -> Organization {
  self.crab.get("/orgs/\{self.org}")
}

///|
pub async fn OrgsHandler::list_repos(
  self : OrgsHandler,
  repo_type? : OrgRepoType,
  sort? : OrgRepoSort,
  direction? : SortDirection,
  per_page? : Int,
  page? : Int,
) -> Page[Repository] {
  let params : Map[String, String] = {}
  if repo_type is Some(repo_type) {
    add_query(params, "type", Some(repo_type.as_query()))
  }
  if sort is Some(sort) {
    add_query(params, "sort", Some(sort.as_query()))
  }
  if direction is Some(direction) {
    add_query(params, "direction", Some(direction.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/orgs/\{self.org}/repos", query=params)
}

///|
pub async fn OrgsHandler::list_members(
  self : OrgsHandler,
  filter? : OrgMemberFilter,
  role? : OrgMemberRole,
  per_page? : Int,
  page? : Int,
) -> Page[User] {
  let params : Map[String, String] = {}
  if filter is Some(filter) {
    add_query(params, "filter", Some(filter.as_query()))
  }
  if role is Some(role) {
    add_query(params, "role", Some(role.as_query()))
  }
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page("/orgs/\{self.org}/members", query=params)
}

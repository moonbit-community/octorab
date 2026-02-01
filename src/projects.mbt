///|
fn projects_headers() -> Map[String, String] {
  { "Accept": "application/vnd.github.inertia-preview+json" }
}

///|
pub async fn Octorab::list_repo_projects(
  self : Octorab,
  owner : String,
  repo : String,
  state? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "state", state)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page(
    "/repos/\{owner}/\{repo}/projects",
    query=params,
    headers=projects_headers(),
  )
}

///|
pub async fn Octorab::list_org_projects(
  self : Octorab,
  org : String,
  state? : String,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query(params, "state", state)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page(
    "/orgs/\{org}/projects",
    query=params,
    headers=projects_headers(),
  )
}

///|
pub async fn Octorab::get_project(self : Octorab, project_id : Int) -> Json {
  self.get("/projects/\{project_id}", headers=projects_headers())
}

///|
pub async fn Octorab::list_project_columns(
  self : Octorab,
  project_id : Int,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page(
    "/projects/\{project_id}/columns",
    query=params,
    headers=projects_headers(),
  )
}

///|
pub async fn Octorab::list_project_cards(
  self : Octorab,
  column_id : Int,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.get_page(
    "/projects/columns/\{column_id}/cards",
    query=params,
    headers=projects_headers(),
  )
}

///|
pub struct HooksHandler {
  crab : Octorab
  owner : String
  repo : String?
}

///|
pub fn Octorab::hooks(self : Octorab, owner : String) -> HooksHandler {
  { crab: self, owner, repo: None }
}

///|
pub fn HooksHandler::repo(self : HooksHandler, repo : String) -> HooksHandler {
  { ..self, repo: Some(repo) }
}

///|
fn HooksHandler::delivery_path(self : HooksHandler, hook_id : Int) -> String {
  match self.repo {
    Some(repo) => "/repos/\{self.owner}/\{repo}/hooks/\{hook_id}/deliveries"
    None => "/orgs/\{self.owner}/hooks/\{hook_id}/deliveries"
  }
}

///|
fn HooksHandler::retry_path(
  self : HooksHandler,
  hook_id : Int,
  delivery_id : Int,
) -> String {
  match self.repo {
    Some(repo) =>
      "/repos/\{self.owner}/\{repo}/hooks/\{hook_id}/deliveries/\{delivery_id}/attempts"
    None =>
      "/orgs/\{self.owner}/hooks/\{hook_id}/deliveries/\{delivery_id}/attempts"
  }
}

///|
pub async fn HooksHandler::list_deliveries(
  self : HooksHandler,
  hook_id : Int,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  let path = self.delivery_path(hook_id)
  self.crab.get_page(path, query=params)
}

///|
pub async fn HooksHandler::retry_delivery(
  self : HooksHandler,
  hook_id : Int,
  delivery_id : Int,
) -> Unit {
  let path = self.retry_path(hook_id, delivery_id)
  let _ = self.crab.request(@http.RequestMethod::Post, path)
  ()
}

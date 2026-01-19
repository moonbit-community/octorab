///|
pub struct WorkflowsHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::workflows(
  self : Octorab,
  owner : String,
  repo : String,
) -> WorkflowsHandler {
  { crab: self, owner, repo }
}

///|
pub async fn WorkflowsHandler::list(
  self : WorkflowsHandler,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/workflows",
    query=params,
  )
}

///|
pub async fn WorkflowsHandler::get_run(
  self : WorkflowsHandler,
  run_id : Int,
) -> Json {
  self.crab.get("/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}")
}

///|
pub async fn WorkflowsHandler::list_runs(
  self : WorkflowsHandler,
  actor? : String,
  branch? : String,
  event? : String,
  status? : String,
  per_page? : Int,
  page? : Int,
  exclude_pull_requests? : Bool,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "actor", actor)
  add_query(params, "branch", branch)
  add_query(params, "event", event)
  add_query(params, "status", status)
  add_query_bool(params, "exclude_pull_requests", exclude_pull_requests)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get("/repos/\{self.owner}/\{self.repo}/actions/runs", query=params)
}

///|
pub async fn WorkflowsHandler::list_runs_for_workflow(
  self : WorkflowsHandler,
  workflow_id : String,
  actor? : String,
  branch? : String,
  event? : String,
  status? : String,
  per_page? : Int,
  page? : Int,
  exclude_pull_requests? : Bool,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "actor", actor)
  add_query(params, "branch", branch)
  add_query(params, "event", event)
  add_query(params, "status", status)
  add_query_bool(params, "exclude_pull_requests", exclude_pull_requests)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/workflows/\{workflow_id}/runs",
    query=params,
  )
}

///|
pub async fn WorkflowsHandler::list_jobs(
  self : WorkflowsHandler,
  run_id : Int,
  filter? : String,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "filter", filter)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/jobs",
    query=params,
  )
}

///|
pub async fn WorkflowsHandler::dispatch(
  self : WorkflowsHandler,
  workflow_id : String,
  workflow_ref : String,
  inputs? : Json,
) -> Unit {
  let payload : Map[String, Json] = {}
  payload["ref"] = Json::string(workflow_ref)
  if inputs is Some(value) {
    payload["inputs"] = value
  }
  let body = Json::object(payload)
  let headers = with_json_header({})
  let _ = self.crab.request(
    @http.RequestMethod::Post,
    "/repos/\{self.owner}/\{self.repo}/actions/workflows/\{workflow_id}/dispatches",
    body~,
    headers~,
  )
  ()
}

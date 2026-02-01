///|
pub struct ActionsHandler {
  crab : Octorab
  owner : String
  repo : String
}

///|
pub fn Octorab::actions(
  self : Octorab,
  owner : String,
  repo : String,
) -> ActionsHandler {
  { crab: self, owner, repo }
}

///|
pub async fn ActionsHandler::list_workflows(
  self : ActionsHandler,
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
pub async fn ActionsHandler::get_workflow(
  self : ActionsHandler,
  workflow_id : Int,
) -> Json {
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/workflows/\{workflow_id}",
  )
}

///|
pub async fn ActionsHandler::list_runs(
  self : ActionsHandler,
  actor? : String,
  branch? : String,
  event? : String,
  status? : String,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "actor", actor)
  add_query(params, "branch", branch)
  add_query(params, "event", event)
  add_query(params, "status", status)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get("/repos/\{self.owner}/\{self.repo}/actions/runs", query=params)
}

///|
pub async fn ActionsHandler::list_workflow_runs(
  self : ActionsHandler,
  workflow_id : Int,
  actor? : String,
  branch? : String,
  event? : String,
  status? : String,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "actor", actor)
  add_query(params, "branch", branch)
  add_query(params, "event", event)
  add_query(params, "status", status)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/workflows/\{workflow_id}/runs",
    query=params,
  )
}

///|
pub async fn ActionsHandler::list_jobs(
  self : ActionsHandler,
  run_id : Int,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/jobs",
    query=params,
  )
}

///|
pub async fn ActionsHandler::list_run_artifacts(
  self : ActionsHandler,
  run_id : Int,
  per_page? : Int,
  page? : Int,
) -> Page[Json] {
  let params : Map[String, String] = {}
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get_page(
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/artifacts",
    query=params,
  )
}

///|
pub async fn ActionsHandler::get_artifact(
  self : ActionsHandler,
  artifact_id : Int,
) -> Json {
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/artifacts/\{artifact_id}",
  )
}

///|
pub async fn ActionsHandler::delete_artifact(
  self : ActionsHandler,
  artifact_id : Int,
) -> Unit {
  self.crab.delete(
    "/repos/\{self.owner}/\{self.repo}/actions/artifacts/\{artifact_id}",
  )
}

///|
pub async fn ActionsHandler::download_artifact(
  self : ActionsHandler,
  artifact_id : Int,
  archive_format? : String = "zip",
) -> &@io.Data {
  let (_response, data) = self.crab.get_raw(
    "/repos/\{self.owner}/\{self.repo}/actions/artifacts/\{artifact_id}/\{archive_format}",
  )
  data
}

///|
pub async fn ActionsHandler::dispatch_workflow(
  self : ActionsHandler,
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

///|
pub async fn ActionsHandler::cancel_run(
  self : ActionsHandler,
  run_id : Int,
) -> Unit {
  let _ = self.crab.request(
    @http.RequestMethod::Post,
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/cancel",
  )
  ()
}

///|
pub async fn ActionsHandler::rerun(self : ActionsHandler, run_id : Int) -> Unit {
  let _ = self.crab.request(
    @http.RequestMethod::Post,
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/rerun",
  )
  ()
}

///|
pub async fn ActionsHandler::rerun_failed_jobs(
  self : ActionsHandler,
  run_id : Int,
) -> Unit {
  let _ = self.crab.request(
    @http.RequestMethod::Post,
    "/repos/\{self.owner}/\{self.repo}/actions/runs/\{run_id}/rerun-failed-jobs",
  )
  ()
}

///|
pub async fn ActionsHandler::list_self_hosted_runners(
  self : ActionsHandler,
  name? : String,
  per_page? : Int,
  page? : Int,
) -> Json {
  let params : Map[String, String] = {}
  add_query(params, "name", name)
  add_query_int(params, "per_page", per_page)
  add_query_int(params, "page", page)
  self.crab.get(
    "/repos/\{self.owner}/\{self.repo}/actions/runners",
    query=params,
  )
}

///|
pub async fn ActionsHandler::create_jit_runner_config(
  self : ActionsHandler,
  name : String,
  runner_group_id : Int,
  labels : Array[String],
  work_folder? : String,
) -> Json {
  let payload : Map[String, Json] = {}
  payload["name"] = Json::string(name)
  payload["runner_group_id"] = Json::number(runner_group_id.to_double())
  payload["labels"] = Json::array(labels.map(Json::string))
  if work_folder is Some(value) {
    payload["work_folder"] = Json::string(value)
  }
  let body = Json::object(payload)
  self.crab.post(
    "/repos/\{self.owner}/\{self.repo}/actions/runners/generate-jitconfig",
    body,
  )
}

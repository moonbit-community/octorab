///|
pub async fn Octorab::graphql(
  self : Octorab,
  query : String,
  variables? : Json,
  operation_name? : String,
) -> Json {
  let payload : Map[String, Json] = {}
  payload["query"] = Json::string(query)
  if variables is Some(vars) {
    payload["variables"] = vars
  }
  if operation_name is Some(name) {
    payload["operationName"] = Json::string(name)
  }
  self.post("/graphql", Json::object(payload))
}

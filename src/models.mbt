///|
pub struct User {
  login : String
  id : Int
  node_id : String?
  avatar_url : String?
  html_url : String?
} derive(Show, Eq, ToJson, FromJson)

///|
pub struct Repository {
  id : Int
  name : String
  full_name : String?
  private : Bool?
  owner : User?
  html_url : String?
  description : String?
  fork : Bool?
  stargazers_count : Int?
  watchers_count : Int?
  language : String?
  default_branch : String?
} derive(Show, Eq, ToJson)

///|
pub struct PullRequestLinks {
  url : String?
  html_url : String?
  diff_url : String?
  patch_url : String?
} derive(Show, Eq, ToJson, FromJson)

///|
pub struct Issue {
  id : Int
  number : Int
  title : String
  state : String?
  user : User?
  body : String?
  comments : Int?
  html_url : String?
  pull_request : PullRequestLinks?
} derive(Show, Eq, ToJson, FromJson)

///|
pub struct Organization {
  login : String
  id : Int
  name : String?
  description : String?
  html_url : String?
  repos_url : String?
} derive(Show, Eq, ToJson, FromJson)

///|
pub struct PullRequest {
  id : Int
  number : Int
  title : String
  state : String?
  user : User?
  body : String?
  html_url : String?
  diff_url : String?
  patch_url : String?
  merged_at : String?
} derive(Show, Eq, ToJson, FromJson)

///|
pub struct PullRequestFile {
  sha : String
  filename : String
  status : String?
  additions : Int?
  deletions : Int?
  changes : Int?
  patch : String?
} derive(Show, Eq, ToJson, FromJson)

///|
fn[T : @json.FromJson] decode_required(
  obj : Map[String, Json],
  key : String,
  path : @json.JsonPath,
) -> T raise @json.JsonDecodeError {
  match obj.get(key) {
    Some(value) => @json.FromJson::from_json(value, path.add_key(key))
    None => raise @json.JsonDecodeError((path.add_key(key), "Missing field"))
  }
}

///|
fn[T : @json.FromJson] decode_optional(
  obj : Map[String, Json],
  key : String,
  path : @json.JsonPath,
) -> T? raise @json.JsonDecodeError {
  match obj.get(key) {
    None => None
    Some(Json::Null) => None
    Some(value) => Some(@json.FromJson::from_json(value, path.add_key(key)))
  }
}

///|
pub impl @json.FromJson for Repository with from_json(json, path) {
  guard json is Json::Object(map) else {
    raise @json.JsonDecodeError(
      (path, "Repository::from_json: expected object"),
    )
  }
  let id : Int = decode_required(map, "id", path)
  let name : String = decode_required(map, "name", path)
  let full_name : String? = decode_optional(map, "full_name", path)
  let private_ : Bool? = decode_optional(map, "private", path)
  let owner : User? = decode_optional(map, "owner", path)
  let html_url : String? = decode_optional(map, "html_url", path)
  let description : String? = decode_optional(map, "description", path)
  let fork : Bool? = decode_optional(map, "fork", path)
  let stargazers_count : Int? = decode_optional(map, "stargazers_count", path)
  let watchers_count : Int? = decode_optional(map, "watchers_count", path)
  let language : String? = decode_optional(map, "language", path)
  let default_branch : String? = decode_optional(map, "default_branch", path)
  {
    id,
    name,
    full_name,
    private: private_,
    owner,
    html_url,
    description,
    fork,
    stargazers_count,
    watchers_count,
    language,
    default_branch,
  }
}

///|
pub struct User {
  login : String
  id : Int32
  node_id : String?
  avatar_url : String?
  html_url : String?
} derive(Eq, ToJson, FromJson)

///|
pub struct Repository {
  id : Int32
  name : String
  full_name : String?
  private : Bool?
  owner : User?
  html_url : String?
  description : String?
  fork : Bool?
  stargazers_count : Int32?
  watchers_count : Int32?
  language : String?
  default_branch : String?
} derive(Eq, ToJson)

///|
pub struct PullRequestLinks {
  url : String?
  html_url : String?
  diff_url : String?
  patch_url : String?
} derive(Eq, ToJson, FromJson)

///|
pub struct Issue {
  id : Int32
  number : Int32
  title : String
  state : String?
  user : User?
  body : String?
  comments : Int32?
  html_url : String?
  pull_request : PullRequestLinks?
} derive(Eq, ToJson, FromJson)

///|
pub struct Organization {
  login : String
  id : Int32
  name : String?
  description : String?
  html_url : String?
  repos_url : String?
} derive(Eq, ToJson, FromJson)

///|
pub struct PullRequest {
  id : Int32
  number : Int32
  title : String
  state : String?
  user : User?
  body : String?
  html_url : String?
  diff_url : String?
  patch_url : String?
  merged_at : String?
} derive(Eq, ToJson, FromJson)

///|
pub struct PullRequestFile {
  sha : String
  filename : String
  status : String?
  additions : Int32?
  deletions : Int32?
  changes : Int32?
  patch : String?
} derive(Eq, ToJson, FromJson)

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
pub impl @json.FromJson for Repository with fn from_json(json, path) {
  guard json is Json::Object(map) else {
    raise @json.JsonDecodeError(
      (path, "Repository::from_json: expected object"),
    )
  }
  let id : Int32 = decode_required(map, "id", path)
  let name : String = decode_required(map, "name", path)
  let full_name : String? = decode_optional(map, "full_name", path)
  let private_ : Bool? = decode_optional(map, "private", path)
  let owner : User? = decode_optional(map, "owner", path)
  let html_url : String? = decode_optional(map, "html_url", path)
  let description : String? = decode_optional(map, "description", path)
  let fork : Bool? = decode_optional(map, "fork", path)
  let stargazers_count : Int32? = decode_optional(map, "stargazers_count", path)
  let watchers_count : Int32? = decode_optional(map, "watchers_count", path)
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

///|
pub impl Show for User with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("login: ")
  logger.write_object(self.login)
  logger.write_string(", id: ")
  logger.write_object(self.id)
  logger.write_string(", node_id: ")
  match self.node_id {
    None => logger.write_string("None")
    Some(value287) => {
      logger.write_string("Some(")
      logger.write_object(value287)
      logger.write_string(")")
    }
  }
  logger.write_string(", avatar_url: ")
  match self.avatar_url {
    None => logger.write_string("None")
    Some(value289) => {
      logger.write_string("Some(")
      logger.write_object(value289)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value291) => {
      logger.write_string("Some(")
      logger.write_object(value291)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for Repository with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("id: ")
  logger.write_object(self.id)
  logger.write_string(", name: ")
  logger.write_object(self.name)
  logger.write_string(", full_name: ")
  match self.full_name {
    None => logger.write_string("None")
    Some(value295) => {
      logger.write_string("Some(")
      logger.write_object(value295)
      logger.write_string(")")
    }
  }
  logger.write_string(", private: ")
  match self.private {
    None => logger.write_string("None")
    Some(value297) => {
      logger.write_string("Some(")
      logger.write_object(value297)
      logger.write_string(")")
    }
  }
  logger.write_string(", owner: ")
  match self.owner {
    None => logger.write_string("None")
    Some(value299) => {
      logger.write_string("Some(")
      logger.write_object(value299)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value301) => {
      logger.write_string("Some(")
      logger.write_object(value301)
      logger.write_string(")")
    }
  }
  logger.write_string(", description: ")
  match self.description {
    None => logger.write_string("None")
    Some(value303) => {
      logger.write_string("Some(")
      logger.write_object(value303)
      logger.write_string(")")
    }
  }
  logger.write_string(", fork: ")
  match self.fork {
    None => logger.write_string("None")
    Some(value305) => {
      logger.write_string("Some(")
      logger.write_object(value305)
      logger.write_string(")")
    }
  }
  logger.write_string(", stargazers_count: ")
  match self.stargazers_count {
    None => logger.write_string("None")
    Some(value307) => {
      logger.write_string("Some(")
      logger.write_object(value307)
      logger.write_string(")")
    }
  }
  logger.write_string(", watchers_count: ")
  match self.watchers_count {
    None => logger.write_string("None")
    Some(value309) => {
      logger.write_string("Some(")
      logger.write_object(value309)
      logger.write_string(")")
    }
  }
  logger.write_string(", language: ")
  match self.language {
    None => logger.write_string("None")
    Some(value311) => {
      logger.write_string("Some(")
      logger.write_object(value311)
      logger.write_string(")")
    }
  }
  logger.write_string(", default_branch: ")
  match self.default_branch {
    None => logger.write_string("None")
    Some(value313) => {
      logger.write_string("Some(")
      logger.write_object(value313)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for PullRequestLinks with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("url: ")
  match self.url {
    None => logger.write_string("None")
    Some(value315) => {
      logger.write_string("Some(")
      logger.write_object(value315)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value317) => {
      logger.write_string("Some(")
      logger.write_object(value317)
      logger.write_string(")")
    }
  }
  logger.write_string(", diff_url: ")
  match self.diff_url {
    None => logger.write_string("None")
    Some(value319) => {
      logger.write_string("Some(")
      logger.write_object(value319)
      logger.write_string(")")
    }
  }
  logger.write_string(", patch_url: ")
  match self.patch_url {
    None => logger.write_string("None")
    Some(value321) => {
      logger.write_string("Some(")
      logger.write_object(value321)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for Issue with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("id: ")
  logger.write_object(self.id)
  logger.write_string(", number: ")
  logger.write_object(self.number)
  logger.write_string(", title: ")
  logger.write_object(self.title)
  logger.write_string(", state: ")
  match self.state {
    None => logger.write_string("None")
    Some(value326) => {
      logger.write_string("Some(")
      logger.write_object(value326)
      logger.write_string(")")
    }
  }
  logger.write_string(", user: ")
  match self.user {
    None => logger.write_string("None")
    Some(value328) => {
      logger.write_string("Some(")
      logger.write_object(value328)
      logger.write_string(")")
    }
  }
  logger.write_string(", body: ")
  match self.body {
    None => logger.write_string("None")
    Some(value330) => {
      logger.write_string("Some(")
      logger.write_object(value330)
      logger.write_string(")")
    }
  }
  logger.write_string(", comments: ")
  match self.comments {
    None => logger.write_string("None")
    Some(value332) => {
      logger.write_string("Some(")
      logger.write_object(value332)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value334) => {
      logger.write_string("Some(")
      logger.write_object(value334)
      logger.write_string(")")
    }
  }
  logger.write_string(", pull_request: ")
  match self.pull_request {
    None => logger.write_string("None")
    Some(value336) => {
      logger.write_string("Some(")
      logger.write_object(value336)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for Organization with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("login: ")
  logger.write_object(self.login)
  logger.write_string(", id: ")
  logger.write_object(self.id)
  logger.write_string(", name: ")
  match self.name {
    None => logger.write_string("None")
    Some(value340) => {
      logger.write_string("Some(")
      logger.write_object(value340)
      logger.write_string(")")
    }
  }
  logger.write_string(", description: ")
  match self.description {
    None => logger.write_string("None")
    Some(value342) => {
      logger.write_string("Some(")
      logger.write_object(value342)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value344) => {
      logger.write_string("Some(")
      logger.write_object(value344)
      logger.write_string(")")
    }
  }
  logger.write_string(", repos_url: ")
  match self.repos_url {
    None => logger.write_string("None")
    Some(value346) => {
      logger.write_string("Some(")
      logger.write_object(value346)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for PullRequest with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("id: ")
  logger.write_object(self.id)
  logger.write_string(", number: ")
  logger.write_object(self.number)
  logger.write_string(", title: ")
  logger.write_object(self.title)
  logger.write_string(", state: ")
  match self.state {
    None => logger.write_string("None")
    Some(value351) => {
      logger.write_string("Some(")
      logger.write_object(value351)
      logger.write_string(")")
    }
  }
  logger.write_string(", user: ")
  match self.user {
    None => logger.write_string("None")
    Some(value353) => {
      logger.write_string("Some(")
      logger.write_object(value353)
      logger.write_string(")")
    }
  }
  logger.write_string(", body: ")
  match self.body {
    None => logger.write_string("None")
    Some(value355) => {
      logger.write_string("Some(")
      logger.write_object(value355)
      logger.write_string(")")
    }
  }
  logger.write_string(", html_url: ")
  match self.html_url {
    None => logger.write_string("None")
    Some(value357) => {
      logger.write_string("Some(")
      logger.write_object(value357)
      logger.write_string(")")
    }
  }
  logger.write_string(", diff_url: ")
  match self.diff_url {
    None => logger.write_string("None")
    Some(value359) => {
      logger.write_string("Some(")
      logger.write_object(value359)
      logger.write_string(")")
    }
  }
  logger.write_string(", patch_url: ")
  match self.patch_url {
    None => logger.write_string("None")
    Some(value361) => {
      logger.write_string("Some(")
      logger.write_object(value361)
      logger.write_string(")")
    }
  }
  logger.write_string(", merged_at: ")
  match self.merged_at {
    None => logger.write_string("None")
    Some(value363) => {
      logger.write_string("Some(")
      logger.write_object(value363)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

///|
pub impl Show for PullRequestFile with fn output(self, logger) {
  logger.write_string("{")
  logger.write_string("sha: ")
  logger.write_object(self.sha)
  logger.write_string(", filename: ")
  logger.write_object(self.filename)
  logger.write_string(", status: ")
  match self.status {
    None => logger.write_string("None")
    Some(value367) => {
      logger.write_string("Some(")
      logger.write_object(value367)
      logger.write_string(")")
    }
  }
  logger.write_string(", additions: ")
  match self.additions {
    None => logger.write_string("None")
    Some(value369) => {
      logger.write_string("Some(")
      logger.write_object(value369)
      logger.write_string(")")
    }
  }
  logger.write_string(", deletions: ")
  match self.deletions {
    None => logger.write_string("None")
    Some(value371) => {
      logger.write_string("Some(")
      logger.write_object(value371)
      logger.write_string(")")
    }
  }
  logger.write_string(", changes: ")
  match self.changes {
    None => logger.write_string("None")
    Some(value373) => {
      logger.write_string("Some(")
      logger.write_object(value373)
      logger.write_string(")")
    }
  }
  logger.write_string(", patch: ")
  match self.patch {
    None => logger.write_string("None")
    Some(value375) => {
      logger.write_string("Some(")
      logger.write_object(value375)
      logger.write_string(")")
    }
  }
  logger.write_string("}")
}

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
} derive(Show, Eq, ToJson, FromJson)

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

///|
/// # Repository API Handler
/// 
/// Provides access to GitHub's repository API endpoints.

///|
/// Repository reference type for API calls
pub enum RepoRef {
  /// Reference by owner and repository name
  ByOwnerAndName(String, String) // owner, repo
  /// Reference by repository ID
  ById(Int)
} derive(Show, Eq)

///|
/// Convert RepoRef to path component
fn RepoRef::to_path(self : RepoRef) -> String {
  match self {
    ByOwnerAndName(owner, repo) => "repos/\{owner}/\{repo}"
    ById(id) => "repositories/\{id}"
  }
}

///|
/// Repository API handler
pub struct RepositoryHandler {
  /// Reference to the GitHub client
  client : Octorab
  /// Repository reference
  repo : RepoRef
} derive(Show, Eq)

///|
/// Create a new repository handler
pub fn Octorab::repositories(
  self : Octorab,
  owner : String,
  repo : String,
) -> RepositoryHandler {
  { client: self, repo: RepoRef::ByOwnerAndName(owner, repo) }
}

///|
/// Create a new repository handler by ID
pub fn Octorab::repositories_by_id(
  self : Octorab,
  id : Int,
) -> RepositoryHandler {
  { client: self, repo: RepoRef::ById(id) }
}

///|
/// Get repository information
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let repo = client.repositories("octocat", "Hello-World").get().await?
/// ```
pub fn RepositoryHandler::get(self : RepositoryHandler) -> GhResult[Repository] {
  let path = "/\{self.repo.to_path()}"
  self.client.get(path)
}

///|
/// List repository branches
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let branches = client.repositories("octocat", "Hello-World").list_branches().await?
/// ```
pub fn RepositoryHandler::list_branches(
  self : RepositoryHandler,
) -> GhResult[Array[Branch]] {
  let path = "/\{self.repo.to_path()}/branches"
  self.client.get(path)
}

///|
/// List repository tags
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let tags = client.repositories("octocat", "Hello-World").list_tags().await?
/// ```
pub fn RepositoryHandler::list_tags(
  self : RepositoryHandler,
) -> GhResult[Array[Tag]] {
  let path = "/\{self.repo.to_path()}/tags"
  self.client.get(path)
}

///|
/// List repository contributors
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let contributors = client.repositories("octocat", "Hello-World").list_contributors().await?
/// ```
pub fn RepositoryHandler::list_contributors(
  self : RepositoryHandler,
) -> GhResult[Array[Contributor]] {
  let path = "/\{self.repo.to_path()}/contributors"
  self.client.get(path)
}

///|
/// List repository languages
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let languages = client.repositories("octocat", "Hello-World").list_languages().await?
/// ```
pub fn RepositoryHandler::list_languages(
  self : RepositoryHandler,
) -> GhResult[Map[String, Int]] {
  let path = "/\{self.repo.to_path()}/languages"
  self.client.get(path)
}

///|
/// Get repository README
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let readme = client.repositories("octocat", "Hello-World").get_readme().await?
/// ```
pub fn RepositoryHandler::get_readme(
  self : RepositoryHandler,
) -> GhResult[Content] {
  let path = "/\{self.repo.to_path()}/readme"
  self.client.get(path)
}

///|
/// Get repository contents at a specific path
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let content = client.repositories("octocat", "Hello-World").get_contents("src/main.rs").await?
/// ```
pub fn RepositoryHandler::get_contents(
  self : RepositoryHandler,
  path : String,
) -> GhResult[Content] {
  let api_path = "/\{self.repo.to_path()}/contents/\{path}"
  self.client.get(api_path)
}

///|
/// Create or update file contents
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let result = client.repositories("octocat", "Hello-World")
///   .create_or_update_file("path/to/file.txt", "commit message", "file content")
///   .await?
/// ```
pub fn RepositoryHandler::create_or_update_file(
  self : RepositoryHandler,
  path : String,
  message : String,
  content : String,
) -> GhResult[FileCommit] {
  let api_path = "/\{self.repo.to_path()}/contents/\{path}"
  let body =
    #|{
    #|  "message": "\{message}",
    #|  "content": "\{content}"
    #|}
  self.client.put(api_path, Some(body))
}

///|
/// Delete a file
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let result = client.repositories("octocat", "Hello-World")
///   .delete_file("path/to/file.txt", "delete message", "file_sha")
///   .await?
/// ```
pub fn RepositoryHandler::delete_file(
  self : RepositoryHandler,
  path : String,
  message : String,
  sha : String,
) -> GhResult[FileCommit] {
  let api_path = "/\{self.repo.to_path()}/contents/\{path}"
  let body =
    #|{
    #|  "message": "\{message}",
    #|  "sha": "\{sha}"
    #|}
  self.client.delete(api_path)
}

///|
/// List repository commits
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let commits = client.repositories("octocat", "Hello-World").list_commits().await?
/// ```
pub fn RepositoryHandler::list_commits(
  self : RepositoryHandler,
) -> GhResult[Array[Commit]] {
  let path = "/\{self.repo.to_path()}/commits"
  self.client.get(path)
}

///|
/// Get a specific commit
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let commit = client.repositories("octocat", "Hello-World")
///   .get_commit("6dcb09b5b57875f334f61aebed695e2e4193db5e")
///   .await?
/// ```
pub fn RepositoryHandler::get_commit(
  self : RepositoryHandler,
  sha : String,
) -> GhResult[Commit] {
  let path = "/\{self.repo.to_path()}/commits/\{sha}"
  self.client.get(path)
}

///|
/// List repository releases
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let releases = client.repositories("octocat", "Hello-World").list_releases().await?
/// ```
pub fn RepositoryHandler::list_releases(
  self : RepositoryHandler,
) -> GhResult[Array[Release]] {
  let path = "/\{self.repo.to_path()}/releases"
  self.client.get(path)
}

///|
/// Get the latest release
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let release = client.repositories("octocat", "Hello-World").get_latest_release().await?
/// ```
pub fn RepositoryHandler::get_latest_release(
  self : RepositoryHandler,
) -> GhResult[Release] {
  let path = "/\{self.repo.to_path()}/releases/latest"
  self.client.get(path)
}

///|
/// Get a release by tag name
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let release = client.repositories("octocat", "Hello-World")
///   .get_release_by_tag("v1.0.0")
///   .await?
/// ```
pub fn RepositoryHandler::get_release_by_tag(
  self : RepositoryHandler,
  tag : String,
) -> GhResult[Release] {
  let path = "/\{self.repo.to_path()}/releases/tags/\{tag}"
  self.client.get(path)
}

///|
/// Create a new release
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let release = client.repositories("octocat", "Hello-World")
///   .create_release("v1.0.0", "Release 1.0.0", "First stable release")
///   .await?
/// ```
pub fn RepositoryHandler::create_release(
  self : RepositoryHandler,
  tag_name : String,
  name : String,
  body : String,
) -> GhResult[Release] {
  let path = "/\{self.repo.to_path()}/releases"
  let request_body =
    #|{
    #|  "tag_name": "\{tag_name}",
    #|  "name": "\{name}",
    #|  "body": "\{body}"
    #|}
  self.client.post(path, Some(request_body))
}

///|
/// Fork a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let fork = client.repositories("octocat", "Hello-World").fork().await?
/// ```
pub fn RepositoryHandler::fork(self : RepositoryHandler) -> GhResult[Repository] {
  let path = "/\{self.repo.to_path()}/forks"
  self.client.post(path, None)
}

///|
/// Star a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.repositories("octocat", "Hello-World").star().await?
/// ```
pub fn RepositoryHandler::star(self : RepositoryHandler) -> GhResult[Unit] {
  let path = "/user/starred/\{self.repo.to_path()}"
  let _result : String = self.client.put(path, None).unwrap()
  Ok(())
}

///|
/// Unstar a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.repositories("octocat", "Hello-World").unstar().await?
/// ```
pub fn RepositoryHandler::unstar(self : RepositoryHandler) -> GhResult[Unit] {
  let path = "/user/starred/\{self.repo.to_path()}"
  let _result : String = self.client.delete(path).unwrap()
  Ok(())
}

///|
/// Check if a repository is starred by the authenticated user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let is_starred = client.repositories("octocat", "Hello-World").is_starred().await?
/// ```
pub fn RepositoryHandler::is_starred(self : RepositoryHandler) -> GhResult[Bool] {
  let path = "/user/starred/\{self.repo.to_path()}"
  // In a real implementation, this would check the HTTP status code
  match self.client.get(path) {
    Ok(_) => Ok(true)
    Err(_) => Ok(false)
  }
}

///|
/// Additional model types needed for repository operations

///|
/// Branch information
pub struct Branch {
  /// Branch name
  name : String
  /// Commit information
  commit : BranchCommit
  /// Whether this branch is protected
  protected : Bool
  /// Protection URL
  protection_url : String
} derive(Show, Eq)

///|
/// Branch commit information
pub struct BranchCommit {
  /// Commit SHA
  sha : String
  /// Commit URL
  url : String
} derive(Show, Eq)

///|
/// Tag information
pub struct Tag {
  /// Tag name
  name : String
  /// Commit information
  commit : TagCommit
  /// Zipball URL
  zipball_url : String
  /// Tarball URL
  tarball_url : String
  /// Node ID for GraphQL
  node_id : String
} derive(Show, Eq)

///|
/// Tag commit information
pub struct TagCommit {
  /// Commit SHA
  sha : String
  /// Commit URL
  url : String
} derive(Show, Eq)

///|
/// Contributor information
pub struct Contributor {
  /// User information
  login : String
  /// User ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Avatar URL
  avatar_url : String
  /// HTML URL
  html_url : String
  /// Contribution count
  contributions : Int
  /// User type
  user_type : String
  /// Whether the user is a site admin
  site_admin : Bool
} derive(Show, Eq)

///|
/// File content information
pub struct Content {
  /// Content type (file, dir, symlink, submodule)
  content_type : String
  /// Content encoding (base64, etc.)
  encoding : String
  /// Content size in bytes
  size : Int
  /// File/directory name
  name : String
  /// File/directory path
  path : String
  /// Content data (base64 encoded for files)
  content : String?
  /// SHA hash
  sha : String
  /// API URL
  url : String
  /// Git URL
  git_url : String
  /// HTML URL
  html_url : String
  /// Download URL (for files)
  download_url : String?
  /// Target (for symlinks)
  target : String?
  /// Submodule Git URL (for submodules)
  submodule_git_url : String?
} derive(Show, Eq)

///|
/// File commit result
pub struct FileCommit {
  /// Commit information
  commit : FileCommitInfo
  /// Content information
  content : Content?
} derive(Show, Eq)

///|
/// File commit information
pub struct FileCommitInfo {
  /// Commit SHA
  sha : String
  /// Node ID for GraphQL
  node_id : String
  /// Commit URL
  url : String
  /// HTML URL
  html_url : String
  /// Commit author
  author : GitUser
  /// Commit committer
  committer : GitUser
  /// Commit message
  message : String
  /// Tree information
  tree : GitObject
  /// Parent commits
  parents : Array[CommitParent]
  /// Verification information
  verification : Verification
} derive(Show, Eq)

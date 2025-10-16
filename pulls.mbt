///|
/// # Pull Requests API Handler
/// 
/// Provides access to GitHub's pull requests API endpoints.

///|
/// Pull Requests API handler
pub struct PullRequestsHandler {
  /// Reference to the GitHub client
  client : Octorab
  /// Repository reference
  repo : RepoRef
} derive(Show, Eq)

///|
/// Create a new pull requests handler
pub fn RepositoryHandler::pulls(
  self : RepositoryHandler,
) -> PullRequestsHandler {
  { client: self.client, repo: self.repo }
}

///|
/// Parameters for listing pull requests
pub struct ListPullRequestsParams {
  /// Filter by PR state (open, closed, all)
  state : String?
  /// Filter by head branch (user:ref-name or organization:ref-name)
  head : String?
  /// Filter by base branch
  base : String?
  /// Sort field (created, updated, popularity, long-running)
  sort : String?
  /// Sort direction (asc, desc)
  direction : String?
  /// Number of results per page (max 100)
  per_page : Int?
  /// Page number of results to retrieve
  page : Int?
} derive(Show, Eq)

///|
/// Default parameters for listing pull requests
pub fn ListPullRequestsParams::default() -> ListPullRequestsParams {
  {
    state: Some("open"),
    head: None,
    base: None,
    sort: Some("created"),
    direction: Some("desc"),
    per_page: Some(30),
    page: Some(1),
  }
}

///|
/// Parameters for creating a pull request
pub struct CreatePullRequestParams {
  /// Pull request title
  title : String
  /// Pull request body/description
  body : String?
  /// Head branch (where changes come from)
  head : String
  /// Base branch (where changes go to)
  base : String
  /// Whether this is a draft pull request
  draft : Bool?
  /// Whether maintainer can modify the PR
  maintainer_can_modify : Bool?
} derive(Show, Eq)

///|
/// Parameters for updating a pull request
pub struct UpdatePullRequestParams {
  /// Pull request title
  title : String?
  /// Pull request body/description
  body : String?
  /// Pull request state (open, closed)
  state : String?
  /// Base branch
  base : String?
  /// Whether maintainer can modify the PR
  maintainer_can_modify : Bool?
} derive(Show, Eq)

///|
/// Parameters for merging a pull request
pub struct MergePullRequestParams {
  /// Commit title for the merge commit
  commit_title : String?
  /// Commit message for the merge commit
  commit_message : String?
  /// SHA that pull request head must match
  sha : String?
  /// Merge method (merge, squash, rebase)
  merge_method : String?
} derive(Show, Eq)

///|
/// List pull requests in a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let pulls = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .list(ListPullRequestsParams::default())
///   .await?
/// ```
pub fn PullRequestsHandler::list(
  self : PullRequestsHandler,
  params : ListPullRequestsParams,
) -> GhResult[Array[PullRequest]] {
  let path = "/\{self.repo.to_path()}/pulls"
  // In a real implementation, params would be converted to query string
  self.client.get(path)
}

///|
/// Get a specific pull request by number
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let pr = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .get(1)
///   .await?
/// ```
pub fn PullRequestsHandler::get(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[PullRequest] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}"
  self.client.get(path)
}

///|
/// Create a new pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let params = {
///   title: "Amazing new feature",
///   body: Some("Please pull these awesome changes"),
///   head: "octocat:new-feature",
///   base: "master",
///   draft: Some(false),
///   maintainer_can_modify: Some(true)
/// }
/// let pr = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .create(params)
///   .await?
/// ```
pub fn PullRequestsHandler::create(
  self : PullRequestsHandler,
  params : CreatePullRequestParams,
) -> GhResult[PullRequest] {
  let path = "/\{self.repo.to_path()}/pulls"
  let body =
    #|{
    #|  "title": "\{params.title}",
    #|  "head": "\{params.head}",
    #|  "base": "\{params.base}"
    #|}
  // In a real implementation, all params would be properly serialized
  self.client.post(path, Some(body))
}

///|
/// Update an existing pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let params = {
///   title: Some("Updated title"),
///   body: Some("Updated description"),
///   state: Some("closed"),
///   base: None,
///   maintainer_can_modify: None
/// }
/// let pr = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .update(1, params)
///   .await?
/// ```
pub fn PullRequestsHandler::update(
  self : PullRequestsHandler,
  pull_number : Int,
  params : UpdatePullRequestParams,
) -> GhResult[PullRequest] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}"
  let body =
    #|{
    #|  "state": "open"
    #|}
  // In a real implementation, all params would be properly serialized
  self.client.patch(path, Some(body))
}

///|
/// List commits in a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let commits = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .list_commits(1)
///   .await?
/// ```
pub fn PullRequestsHandler::list_commits(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[Array[Commit]] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/commits"
  self.client.get(path)
}

///|
/// List files changed in a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let files = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .list_files(1)
///   .await?
/// ```
pub fn PullRequestsHandler::list_files(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[Array[PullRequestFile]] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/files"
  self.client.get(path)
}

///|
/// Check if a pull request has been merged
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let is_merged = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .is_merged(1)
///   .await?
/// ```
pub fn PullRequestsHandler::is_merged(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[Bool] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/merge"
  // In a real implementation, this would check HTTP status code (204 = merged, 404 = not merged)
  match self.client.get(path) {
    Ok(_) => Ok(true)
    Err(_) => Ok(false)
  }
}

///|
/// Merge a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let params = {
///   commit_title: Some("Merge pull request #1"),
///   commit_message: Some("This is a great feature"),
///   sha: Some("6dcb09b5b57875f334f61aebed695e2e4193db5e"),
///   merge_method: Some("merge")
/// }
/// let result = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .merge(1, params)
///   .await?
/// ```
pub fn PullRequestsHandler::merge(
  self : PullRequestsHandler,
  pull_number : Int,
  params : MergePullRequestParams,
) -> GhResult[PullRequestMergeResult] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/merge"
  let body =
    #|{
    #|  "merge_method": "merge"
    #|}
  // In a real implementation, all params would be properly serialized
  self.client.put(path, Some(body))
}

///|
/// Update the branch of a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let result = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .update_branch(1)
///   .await?
/// ```
pub fn PullRequestsHandler::update_branch(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[PullRequestUpdateBranchResult] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/update-branch"
  let body = "{}"
  self.client.put(path, Some(body))
}

///|
/// List reviews for a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let reviews = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .list_reviews(1)
///   .await?
/// ```
pub fn PullRequestsHandler::list_reviews(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[Array[PullRequestReview]] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/reviews"
  self.client.get(path)
}

///|
/// Get a specific review
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let review = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .get_review(1, 123456)
///   .await?
/// ```
pub fn PullRequestsHandler::get_review(
  self : PullRequestsHandler,
  pull_number : Int,
  review_id : Int,
) -> GhResult[PullRequestReview] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/reviews/\{review_id}"
  self.client.get(path)
}

///|
/// Create a review for a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let review = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .create_review(1, "APPROVE", Some("Looks good!"))
///   .await?
/// ```
pub fn PullRequestsHandler::create_review(
  self : PullRequestsHandler,
  pull_number : Int,
  event : String,
  body : String?,
) -> GhResult[PullRequestReview] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/reviews"
  let request_body =
    #|{
    #|  "event": "\{event}"
    #|}
  // In a real implementation, body would be included if provided
  self.client.post(path, Some(request_body))
}

///|
/// Submit a pending review
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let review = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .submit_review(1, 123456, "APPROVE", Some("LGTM!"))
///   .await?
/// ```
pub fn PullRequestsHandler::submit_review(
  self : PullRequestsHandler,
  pull_number : Int,
  review_id : Int,
  event : String,
  body : String?,
) -> GhResult[PullRequestReview] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/reviews/\{review_id}/events"
  let request_body =
    #|{
    #|  "event": "\{event}"
    #|}
  // In a real implementation, body would be included if provided
  self.client.post(path, Some(request_body))
}

///|
/// Dismiss a review
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let review = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .dismiss_review(1, 123456, "Outdated")
///   .await?
/// ```
pub fn PullRequestsHandler::dismiss_review(
  self : PullRequestsHandler,
  pull_number : Int,
  review_id : Int,
  message : String,
) -> GhResult[PullRequestReview] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/reviews/\{review_id}/dismissals"
  let body =
    #|{
    #|  "message": "\{message}"
    #|}
  self.client.put(path, Some(body))
}

///|
/// List review comments on a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comments = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .list_review_comments(1)
///   .await?
/// ```
pub fn PullRequestsHandler::list_review_comments(
  self : PullRequestsHandler,
  pull_number : Int,
) -> GhResult[Array[PullRequestReviewComment]] {
  let path = "/\{self.repo.to_path()}/pulls/\{pull_number}/comments"
  self.client.get(path)
}

///|
/// Create a review comment on a pull request
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comment = client.repositories("octocat", "Hello-World")
///   .pulls()
///   .create_review_comment(1, "This looks good", "sha", "path/to/file.rs", 10)
///   .await?
/// ```
pub fn PullRequestsHandler::create_review_comment(
  self : PullRequestsHandler,
  pull_number : Int,
  body : String,
  commit_id : String,
  path : String,
  line : Int,
) -> GhResult[PullRequestReviewComment] {
  let api_path = "/\{self.repo.to_path()}/pulls/\{pull_number}/comments"
  let request_body =
    #|{
    #|  "body": "\{body}",
    #|  "commit_id": "\{commit_id}",
    #|  "path": "\{path}",
    #|  "line": \{line}
    #|}
  self.client.post(api_path, Some(request_body))
}

///|
/// Additional model types for pull requests

///|
/// Pull request file information
pub struct PullRequestFile {
  /// File SHA
  sha : String
  /// File name
  filename : String
  /// File status (added, removed, modified, renamed, copied, changed, unchanged)
  status : String
  /// Number of additions
  additions : Int
  /// Number of deletions
  deletions : Int
  /// Number of changes
  changes : Int
  /// Blob URL
  blob_url : String
  /// Raw URL
  raw_url : String
  /// Contents URL
  contents_url : String
  /// Patch content
  patch : String?
  /// Previous filename (for renames)
  previous_filename : String?
} derive(Show, Eq)

///|
/// Pull request merge result
pub struct PullRequestMergeResult {
  /// SHA of the merge commit
  sha : String
  /// Whether the merge was successful
  merged : Bool
  /// Merge message
  message : String
} derive(Show, Eq)

///|
/// Pull request update branch result
pub struct PullRequestUpdateBranchResult {
  /// Update message
  message : String
  /// Update URL
  url : String
} derive(Show, Eq)

///|
/// Pull request review information
pub struct PullRequestReview {
  /// Review ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Review user
  user : User
  /// Review body
  body : String?
  /// Review state (PENDING, APPROVED, CHANGES_REQUESTED, COMMENTED, DISMISSED)
  state : String
  /// HTML URL
  html_url : String
  /// Pull request URL
  pull_request_url : String
  /// Author association
  author_association : String
  /// Submission date
  submitted_at : String?
  /// Commit ID
  commit_id : String
} derive(Show, Eq)

///|
/// Pull request review comment information
pub struct PullRequestReviewComment {
  /// Comment ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Diff hunk
  diff_hunk : String
  /// File path
  path : String
  /// Line number
  line : Int?
  /// Commit ID
  commit_id : String
  /// Original commit ID
  original_commit_id : String
  /// Comment body
  body : String
  /// Comment user
  user : User
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// HTML URL
  html_url : String
  /// Pull request URL
  pull_request_url : String
  /// Author association
  author_association : String
  /// In reply to ID
  in_reply_to_id : Int?
  /// Reactions summary
  reactions : Reactions?
} derive(Show, Eq)

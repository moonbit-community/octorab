///|
/// # Issues API Handler
/// 
/// Provides access to GitHub's issues API endpoints.

///|
/// Issues API handler
pub struct IssuesHandler {
  /// Reference to the GitHub client
  client : Octorab
  /// Repository reference
  repo : RepoRef
} derive(Show, Eq)

///|
/// Create a new issues handler
pub fn RepositoryHandler::issues(self : RepositoryHandler) -> IssuesHandler {
  { client: self.client, repo: self.repo }
}

///|
/// Parameters for listing issues
pub struct ListIssuesParams {
  /// Filter by milestone number, or 'none' for issues with no milestone, or '*' for any milestone
  milestone : String?
  /// Filter by issue state
  state : IssueState?
  /// Filter by assignee username, or 'none' for unassigned issues, or '*' for any assignee
  assignee : String?
  /// Filter by issue creator
  creator : String?
  /// Filter by user mentioned in the issue
  mentioned : String?
  /// Filter by labels (comma-separated list)
  labels : String?
  /// Sort field (created, updated, comments)
  sort : String?
  /// Sort direction (asc, desc)
  direction : String?
  /// Filter by when the issue was created (ISO 8601 timestamp)
  since : String?
  /// Number of results per page (max 100)
  per_page : Int?
  /// Page number of results to retrieve
  page : Int?
} derive(Show, Eq)

///|
/// Default parameters for listing issues
pub fn ListIssuesParams::default() -> ListIssuesParams {
  {
    milestone: None,
    state: Some(IssueState::Open),
    assignee: None,
    creator: None,
    mentioned: None,
    labels: None,
    sort: Some("created"),
    direction: Some("desc"),
    since: None,
    per_page: Some(30),
    page: Some(1),
  }
}

///|
/// Parameters for creating an issue
pub(all) struct CreateIssueParams {
  /// Issue title
  title : String
  /// Issue body/description
  body : String?
  /// Username to assign the issue to
  assignee : String?
  /// Milestone number
  milestone : Int?
  /// Array of label names
  labels : Array[String]?
  /// Array of usernames to assign
  assignees : Array[String]?
} derive(Show, Eq)

///|
/// Parameters for updating an issue
pub struct UpdateIssueParams {
  /// Issue title
  title : String?
  /// Issue body/description
  body : String?
  /// Username to assign the issue to
  assignee : String?
  /// Issue state
  state : IssueState?
  /// Milestone number
  milestone : Int?
  /// Array of label names
  labels : Array[String]?
  /// Array of usernames to assign
  assignees : Array[String]?
} derive(Show, Eq)

///|
/// List issues in a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let issues = client.repositories("octocat", "Hello-World")
///   .issues()
///   .list(ListIssuesParams::default())
///   .await?
/// ```
pub fn IssuesHandler::list(
  self : IssuesHandler,
  params : ListIssuesParams,
) -> GhResult[Array[Issue]] {
  let path = "/\{self.repo.to_path()}/issues"
  // In a real implementation, params would be converted to query string
  self.client.get(path)
}

///|
/// Get a specific issue by number
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let issue = client.repositories("octocat", "Hello-World")
///   .issues()
///   .get(1)
///   .await?
/// ```
pub fn IssuesHandler::get(
  self : IssuesHandler,
  issue_number : Int,
) -> GhResult[Issue] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}"
  self.client.get(path)
}

///|
/// Create a new issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let params = {
///   title: "Found a bug",
///   body: Some("I'm having a problem with this."),
///   assignee: None,
///   milestone: None,
///   labels: Some(["bug"]),
///   assignees: None
/// }
/// let issue = client.repositories("octocat", "Hello-World")
///   .issues()
///   .create(params)
///   .await?
/// ```
pub fn IssuesHandler::create(
  self : IssuesHandler,
  params : CreateIssueParams,
) -> GhResult[Issue] {
  let path = "/\{self.repo.to_path()}/issues"
  let body =
    #|{
    #|  "title": "\{params.title}"
    #|}
  // In a real implementation, all params would be properly serialized
  self.client.post(path, Some(body))
}

///|
/// Update an existing issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let params = {
///   title: Some("Updated title"),
///   body: Some("Updated description"),
///   assignee: None,
///   state: Some(IssueState::Closed),
///   milestone: None,
///   labels: None,
///   assignees: None
/// }
/// let issue = client.repositories("octocat", "Hello-World")
///   .issues()
///   .update(1, params)
///   .await?
/// ```
pub fn IssuesHandler::update(
  self : IssuesHandler,
  issue_number : Int,
  params : UpdateIssueParams,
) -> GhResult[Issue] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}"
  let body =
    #|{
    #|  "state": "open"
    #|}
  // In a real implementation, all params would be properly serialized
  self.client.patch(path, Some(body))
}

///|
/// Lock an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.repositories("octocat", "Hello-World")
///   .issues()
///   .lock(1, Some("spam"))
///   .await?
/// ```
pub fn IssuesHandler::lock(
  self : IssuesHandler,
  issue_number : Int,
  lock_reason : String?,
) -> GhResult[Unit] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/lock"
  let body = match lock_reason {
    Some(reason) =>
      (
        #|{
        #|  "lock_reason": "\{reason}"
        #|}
      )
    None => "{}"
  }
  let _result : String = self.client.put(path, Some(body)).unwrap()
  Ok(())
}

///|
/// Unlock an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.repositories("octocat", "Hello-World")
///   .issues()
///   .unlock(1)
///   .await?
/// ```
pub fn IssuesHandler::unlock(
  self : IssuesHandler,
  issue_number : Int,
) -> GhResult[Unit] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/lock"
  let _result : String = self.client.delete(path).unwrap()
  Ok(())
}

///|
/// List comments on an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comments = client.repositories("octocat", "Hello-World")
///   .issues()
///   .list_comments(1)
///   .await?
/// ```
pub fn IssuesHandler::list_comments(
  self : IssuesHandler,
  issue_number : Int,
) -> GhResult[Array[IssueComment]] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/comments"
  self.client.get(path)
}

///|
/// Create a comment on an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comment = client.repositories("octocat", "Hello-World")
///   .issues()
///   .create_comment(1, "This is a comment")
///   .await?
/// ```
pub fn IssuesHandler::create_comment(
  self : IssuesHandler,
  issue_number : Int,
  body : String,
) -> GhResult[IssueComment] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/comments"
  let request_body =
    #|{
    #|  "body": "\{body}"
    #|}
  self.client.post(path, Some(request_body))
}

///|
/// Get a specific comment
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comment = client.repositories("octocat", "Hello-World")
///   .issues()
///   .get_comment(123456)
///   .await?
/// ```
pub fn IssuesHandler::get_comment(
  self : IssuesHandler,
  comment_id : Int,
) -> GhResult[IssueComment] {
  let path = "/\{self.repo.to_path()}/issues/comments/\{comment_id}"
  self.client.get(path)
}

///|
/// Update a comment
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let comment = client.repositories("octocat", "Hello-World")
///   .issues()
///   .update_comment(123456, "Updated comment")
///   .await?
/// ```
pub fn IssuesHandler::update_comment(
  self : IssuesHandler,
  comment_id : Int,
  body : String,
) -> GhResult[IssueComment] {
  let path = "/\{self.repo.to_path()}/issues/comments/\{comment_id}"
  let request_body =
    #|{
    #|  "body": "\{body}"
    #|}
  self.client.patch(path, Some(request_body))
}

///|
/// Delete a comment
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.repositories("octocat", "Hello-World")
///   .issues()
///   .delete_comment(123456)
///   .await?
/// ```
pub fn IssuesHandler::delete_comment(
  self : IssuesHandler,
  comment_id : Int,
) -> GhResult[Unit] {
  let path = "/\{self.repo.to_path()}/issues/comments/\{comment_id}"
  let _result : String = self.client.delete(path).unwrap()
  Ok(())
}

///|
/// List assignees for a repository
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let assignees = client.repositories("octocat", "Hello-World")
///   .issues()
///   .list_assignees()
///   .await?
/// ```
pub fn IssuesHandler::list_assignees(
  self : IssuesHandler,
) -> GhResult[Array[SimpleUser]] {
  let path = "/\{self.repo.to_path()}/assignees"
  self.client.get(path)
}

///|
/// Check if a user can be assigned to issues
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let can_assign = client.repositories("octocat", "Hello-World")
///   .issues()
///   .check_assignee("octocat")
///   .await?
/// ```
pub fn IssuesHandler::check_assignee(
  self : IssuesHandler,
  assignee : String,
) -> GhResult[Bool] {
  let path = "/\{self.repo.to_path()}/assignees/\{assignee}"
  // In a real implementation, this would check the HTTP status code
  match self.client.get(path) {
    Ok(_) => Ok(true)
    Err(_) => Ok(false)
  }
}

///|
/// Add assignees to an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let issue = client.repositories("octocat", "Hello-World")
///   .issues()
///   .add_assignees(1, ["octocat", "hubot"])
///   .await?
/// ```
pub fn IssuesHandler::add_assignees(
  self : IssuesHandler,
  issue_number : Int,
  assignees : Array[String],
) -> GhResult[Issue] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/assignees"
  let body =
    #|{
    #|  "assignees": []
    #|}
  // In a real implementation, assignees array would be properly serialized
  self.client.post(path, Some(body))
}

///|
/// Remove assignees from an issue
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let issue = client.repositories("octocat", "Hello-World")
///   .issues()
///   .remove_assignees(1, ["octocat"])
///   .await?
/// ```
pub fn IssuesHandler::remove_assignees(
  self : IssuesHandler,
  issue_number : Int,
  assignees : Array[String],
) -> GhResult[Issue] {
  let path = "/\{self.repo.to_path()}/issues/\{issue_number}/assignees"
  let body =
    #|{
    #|  "assignees": []
    #|}
  // In a real implementation, assignees array would be properly serialized
  self.client.delete_with_body(path, Some(body))
}

///|
/// Additional model types for issues

///|
/// Issue comment information
pub struct IssueComment {
  /// Comment ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Comment URL
  url : String
  /// HTML URL
  html_url : String
  /// Comment body
  body : String
  /// Comment author
  user : User
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Issue URL
  issue_url : String
  /// Author association
  author_association : String
  /// Reactions summary
  reactions : Reactions?
} derive(Show, Eq)

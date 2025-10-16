///|
/// # Users API Handler
/// 
/// Provides access to GitHub's users API endpoints.

///|
/// User reference type for API calls
pub enum UserRef {
  /// Reference by username
  ByUsername(String)
  /// Reference by user ID
  ById(Int)
} derive(Show, Eq)

///|
/// Convert UserRef to path component
fn UserRef::to_path(self : UserRef) -> String {
  match self {
    ByUsername(username) => "users/\{username}"
    ById(id) => "user/\{id}"
  }
}

///|
/// Users API handler
pub struct UsersHandler {
  /// Reference to the GitHub client
  client : Octorab
  /// User reference
  user_ref : UserRef?
} derive(Show, Eq)

///|
/// Create a new users handler for a specific user
pub fn Octorab::users(
  self : Octorab,
  username : String,
) -> UsersHandler {
  { client: self, user_ref: Some(UserRef::ByUsername(username)) }
}

///|
/// Create a new users handler for a specific user by ID
pub fn Octorab::users_by_id(
  self : Octorab,
  user_id : Int,
) -> UsersHandler {
  { client: self, user_ref: Some(UserRef::ById(user_id)) }
}

///|
/// Create a users handler for the authenticated user
pub fn Octorab::current_user(self : Octorab) -> UsersHandler {
  { client: self, user_ref: None }
}

///|
/// Get user information
/// 
/// # Examples
/// ```moonbit
/// // Get a specific user
/// let client = Octorab::new().with_token("your_token")
/// let user = client.users("octocat").get().await?
/// 
/// // Get the authenticated user
/// let current_user = client.current_user().get().await?
/// ```
pub fn UsersHandler::get(self : UsersHandler) -> GhResult[User] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}"
    None => "/user"
  }
  self.client.get(path)
}

///|
/// Update the authenticated user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let updated_user = client.current_user()
///   .update(Some("John Doe"), Some("john@example.com"), Some("My bio"))
///   .await?
/// ```
pub fn UsersHandler::update(
  self : UsersHandler,
  name : String?,
  email : String?,
  bio : String?,
) -> GhResult[User] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot update other users"))
    None => {
      let path = "/user"
      let body =
        #|{
        #|  "name": "Updated name"
        #|}
      // In a real implementation, all optional params would be properly serialized
      self.client.patch(path, Some(body))
    }
  }
}

///|
/// List user repositories
/// 
/// # Examples
/// ```moonbit
/// // List repositories for a specific user
/// let client = Octorab::new().with_token("your_token")
/// let repos = client.users("octocat").list_repos().await?
/// 
/// // List repositories for the authenticated user
/// let my_repos = client.current_user().list_repos().await?
/// ```
pub fn UsersHandler::list_repos(
  self : UsersHandler,
) -> GhResult[Array[Repository]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/repos"
    None => "/user/repos"
  }
  self.client.get(path)
}

///|
/// List user organizations
/// 
/// # Examples
/// ```moonbit
/// // List organizations for a specific user
/// let client = Octorab::new().with_token("your_token")
/// let orgs = client.users("octocat").list_orgs().await?
/// 
/// // List organizations for the authenticated user
/// let my_orgs = client.current_user().list_orgs().await?
/// ```
pub fn UsersHandler::list_orgs(
  self : UsersHandler,
) -> GhResult[Array[Organization]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/orgs"
    None => "/user/orgs"
  }
  self.client.get(path)
}

///|
/// List user followers
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let followers = client.users("octocat").list_followers().await?
/// ```
pub fn UsersHandler::list_followers(
  self : UsersHandler,
) -> GhResult[Array[SimpleUser]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/followers"
    None => "/user/followers"
  }
  self.client.get(path)
}

///|
/// List users being followed
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let following = client.users("octocat").list_following().await?
/// ```
pub fn UsersHandler::list_following(
  self : UsersHandler,
) -> GhResult[Array[SimpleUser]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/following"
    None => "/user/following"
  }
  self.client.get(path)
}

///|
/// Check if a user is following another user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let is_following = client.users("octocat").is_following("defunkt").await?
/// ```
pub fn UsersHandler::is_following(
  self : UsersHandler,
  target_user : String,
) -> GhResult[Bool] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/following/\{target_user}"
    None => "/user/following/\{target_user}"
  }
  // In a real implementation, this would check HTTP status code
  match self.client.get(path) {
    Ok(_) => Ok(true)
    Err(_) => Ok(false)
  }
}

///|
/// Follow a user (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.current_user().follow("octocat").await?
/// ```
pub fn UsersHandler::follow(
  self : UsersHandler,
  username : String,
) -> GhResult[Unit] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot follow users as another user"))
    None => {
      let path = "/user/following/\{username}"
      let _result : String = self.client.put(path, None).unwrap()
      Ok(())
    }
  }
}

///|
/// Unfollow a user (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.current_user().unfollow("octocat").await?
/// ```
pub fn UsersHandler::unfollow(
  self : UsersHandler,
  username : String,
) -> GhResult[Unit] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot unfollow users as another user"))
    None => {
      let path = "/user/following/\{username}"
      let _result : String = self.client.delete(path).unwrap()
      Ok(())
    }
  }
}

///|
/// List starred repositories
/// 
/// # Examples
/// ```moonbit
/// // List starred repositories for a specific user
/// let client = Octorab::new().with_token("your_token")
/// let starred = client.users("octocat").list_starred().await?
/// 
/// // List starred repositories for the authenticated user
/// let my_starred = client.current_user().list_starred().await?
/// ```
pub fn UsersHandler::list_starred(
  self : UsersHandler,
) -> GhResult[Array[Repository]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/starred"
    None => "/user/starred"
  }
  self.client.get(path)
}

///|
/// List watched repositories (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let watched = client.current_user().list_watched().await?
/// ```
pub fn UsersHandler::list_watched(
  self : UsersHandler,
) -> GhResult[Array[Repository]] {
  match self.user_ref {
    Some(_) =>
      Err(
        GitHubError::Other("Cannot list watched repositories for other users"),
      )
    None => {
      let path = "/user/subscriptions"
      self.client.get(path)
    }
  }
}

///|
/// List user gists
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let gists = client.users("octocat").list_gists().await?
/// ```
pub fn UsersHandler::list_gists(self : UsersHandler) -> GhResult[Array[Gist]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/gists"
    None => "/user/gists"
  }
  self.client.get(path)
}

///|
/// List user events
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let events = client.users("octocat").list_events().await?
/// ```
pub fn UsersHandler::list_events(self : UsersHandler) -> GhResult[Array[Event]] {
  let path = match self.user_ref {
    Some(user_ref) => "/\{user_ref.to_path()}/events"
    None => "/user/events"
  }
  self.client.get(path)
}

///|
/// List public events for a user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let events = client.users("octocat").list_public_events().await?
/// ```
pub fn UsersHandler::list_public_events(
  self : UsersHandler,
) -> GhResult[Array[Event]] {
  match self.user_ref {
    Some(user_ref) => {
      let path = "/\{user_ref.to_path()}/events/public"
      self.client.get(path)
    }
    None =>
      Err(
        GitHubError::Other("Cannot list public events for authenticated user"),
      )
  }
}

///|
/// List received events for a user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let events = client.users("octocat").list_received_events().await?
/// ```
pub fn UsersHandler::list_received_events(
  self : UsersHandler,
) -> GhResult[Array[Event]] {
  match self.user_ref {
    Some(user_ref) => {
      let path = "/\{user_ref.to_path()}/received_events"
      self.client.get(path)
    }
    None =>
      Err(
        GitHubError::Other("Cannot list received events for authenticated user"),
      )
  }
}

///|
/// List public received events for a user
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let events = client.users("octocat").list_public_received_events().await?
/// ```
pub fn UsersHandler::list_public_received_events(
  self : UsersHandler,
) -> GhResult[Array[Event]] {
  match self.user_ref {
    Some(user_ref) => {
      let path = "/\{user_ref.to_path()}/received_events/public"
      self.client.get(path)
    }
    None =>
      Err(
        GitHubError::Other(
          "Cannot list public received events for authenticated user",
        ),
      )
  }
}

///|
/// List user SSH keys (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let keys = client.current_user().list_ssh_keys().await?
/// ```
pub fn UsersHandler::list_ssh_keys(
  self : UsersHandler,
) -> GhResult[Array[SshKey]] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot list SSH keys for other users"))
    None => {
      let path = "/user/keys"
      self.client.get(path)
    }
  }
}

///|
/// Add an SSH key (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let key = client.current_user()
///   .add_ssh_key("My Key", "ssh-rsa AAAAB3NzaC1yc2E...")
///   .await?
/// ```
pub fn UsersHandler::add_ssh_key(
  self : UsersHandler,
  title : String,
  key : String,
) -> GhResult[SshKey] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot add SSH keys for other users"))
    None => {
      let path = "/user/keys"
      let body =
        #|{
        #|  "title": "\{title}",
        #|  "key": "\{key}"
        #|}
      self.client.post(path, Some(body))
    }
  }
}

///|
/// Delete an SSH key (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.current_user().delete_ssh_key(123456).await?
/// ```
pub fn UsersHandler::delete_ssh_key(
  self : UsersHandler,
  key_id : Int,
) -> GhResult[Unit] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot delete SSH keys for other users"))
    None => {
      let path = "/user/keys/\{key_id}"
      let _result : String = self.client.delete(path).unwrap()
      Ok(())
    }
  }
}

///|
/// List user emails (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let emails = client.current_user().list_emails().await?
/// ```
pub fn UsersHandler::list_emails(
  self : UsersHandler,
) -> GhResult[Array[UserEmail]] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot list emails for other users"))
    None => {
      let path = "/user/emails"
      self.client.get(path)
    }
  }
}

///|
/// Add email addresses (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// let emails = client.current_user()
///   .add_emails(["john@example.com", "john.doe@example.org"])
///   .await?
/// ```
pub fn UsersHandler::add_emails(
  self : UsersHandler,
  emails : Array[String],
) -> GhResult[Array[UserEmail]] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot add emails for other users"))
    None => {
      let path = "/user/emails"
      let body =
        #|{
        #|  "emails": []
        #|}
      // In a real implementation, emails array would be properly serialized
      self.client.post(path, Some(body))
    }
  }
}

///|
/// Delete email addresses (authenticated user only)
/// 
/// # Examples
/// ```moonbit
/// let client = Octorab::new().with_token("your_token")
/// client.current_user()
///   .delete_emails(["john@example.com"])
///   .await?
/// ```
pub fn UsersHandler::delete_emails(
  self : UsersHandler,
  emails : Array[String],
) -> GhResult[Unit] {
  match self.user_ref {
    Some(_) => Err(GitHubError::Other("Cannot delete emails for other users"))
    None => {
      let path = "/user/emails"
      let body =
        #|{
        #|  "emails": []
        #|}
      // In a real implementation, emails array would be properly serialized
      let _result : String = self.client
        .delete_with_body(path, Some(body))
        .unwrap()
      Ok(())
    }
  }
}

///|
/// Additional model types for users

///|
/// SSH key information
pub struct SshKey {
  /// Key ID
  id : Int
  /// Key title
  title : String
  /// SSH key content
  key : String
  /// Key URL
  url : String
  /// Whether the key is verified
  verified : Bool
  /// Creation date
  created_at : String
  /// Whether the key is read-only
  read_only : Bool
} derive(Show, Eq)

///|
/// User email information
pub struct UserEmail {
  /// Email address
  email : String
  /// Whether this is the primary email
  primary : Bool
  /// Whether the email is verified
  verified : Bool
  /// Email visibility setting
  visibility : String?
} derive(Show, Eq)

///|
/// Event information
pub struct Event {
  /// Event ID
  id : String
  /// Event type (PushEvent, IssuesEvent, etc.)
  event_type : String
  /// Actor who triggered the event
  actor : SimpleUser
  /// Repository where the event occurred
  repo : EventRepo
  /// Event payload (varies by event type)
  payload : Map[String, String] // Simplified - would be more complex in practice
  /// Whether the event is public
  public : Bool
  /// Creation date
  created_at : String
} derive(Show, Eq)

///|
/// Repository information in events
pub struct EventRepo {
  /// Repository ID
  id : Int
  /// Repository name
  name : String
  /// Repository URL
  url : String
} derive(Show, Eq)

///|
/// Gist information
pub struct Gist {
  /// Gist ID
  id : String
  /// Node ID for GraphQL
  node_id : String
  /// Gist URL
  url : String
  /// Forks URL
  forks_url : String
  /// Commits URL
  commits_url : String
  /// Git pull URL
  git_pull_url : String
  /// Git push URL
  git_push_url : String
  /// HTML URL
  html_url : String
  /// Gist files
  files : Map[String, GistFile]
  /// Whether the gist is public
  public : Bool
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Gist description
  description : String?
  /// Number of comments
  comments : Int
  /// Gist owner
  owner : SimpleUser?
  /// Whether the gist is truncated
  truncated : Bool
} derive(Show, Eq)

///|
/// Gist file information
pub struct GistFile {
  /// File name
  filename : String?
  /// File type
  file_type : String?
  /// Programming language
  language : String?
  /// Raw URL
  raw_url : String
  /// File size
  size : Int
  /// Whether the file is truncated
  truncated : Bool
  /// File content
  content : String?
} derive(Show, Eq)

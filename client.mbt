///|
/// # GitHub API Client
/// 
/// A modern MoonBit library for interacting with the GitHub REST API.
/// Inspired by the octocrab Rust library design.

///|
/// Base URL for GitHub's REST API
pub let github_api_url : String = "https://api.github.com"

///|
/// Base URL for GitHub's upload API
pub let github_upload_url : String = "https://uploads.github.com"

///|
/// Represents different authentication methods for GitHub API
pub enum Auth {
  /// No authentication
  None
  /// Basic authentication with username and password
  Basic(username~ : String, password~ : String) // username, password
  /// GitHub App authentication
  App(AppAuth)
  /// Authentication via a Github App repo-specific installation
  Installation(app~ : AppAuth, installation~ : UInt64, token~ : CachedToken)
  /// Access token based authentication.
  AccessToken(secret~ : String)
} derive(Show, Eq)

struct CachedToken {
  secret : String
  expiration : Int
} derive(Show, Eq)

///|
/// GitHub App authentication information
pub struct AppAuth {
  /// The GitHub App ID
  app_id : Int
  /// The private key for signing JWT tokens
  private_key : String
} derive(Show, Eq)

///|
/// HTTP methods supported by the GitHub API
pub enum HttpMethod {
  GET
  POST
  PUT
  PATCH
  DELETE
} derive(Show, Eq)

///|
/// HTTP headers for API requests
pub struct Headers {
  /// Content type header
  content_type : String?
  /// Authorization header
  authorization : String?
  /// Accept header for API version
  accept : String?
  /// User agent header
  user_agent : String?
  /// Additional custom headers
  extra : Map[String, String]
} derive(Show, Eq)

///|
/// Default headers constructor
pub fn Headers::new() -> Headers {
  {
    content_type: Some("application/json"),
    authorization: None,
    accept: Some("application/vnd.github.v3+json"),
    user_agent: Some("moonbit-github-client/0.1.0"),
    extra: Map::new(),
  }
}

///|
/// Configuration options for the GitHub client
pub struct ClientConfig {
  /// Base URL for API requests
  base_url : String
  /// Base URL for upload requests
  upload_url : String
  /// Authentication method
  auth : Auth
  /// Default timeout for requests (in milliseconds)
  timeout : Int
  /// Whether to follow redirects
  follow_redirects : Bool
  /// Maximum number of redirects to follow
  max_redirects : Int
} derive(Show, Eq)

///|
/// Default client configuration
pub fn ClientConfig::default() -> ClientConfig {
  {
    base_url: github_api_url,
    upload_url: github_upload_url,
    auth: Auth::None,
    timeout: 30000, // 30 seconds
    follow_redirects: true,
    max_redirects: 10,
  }
}

///|
/// Error types for GitHub API operations
pub enum GitHubError {
  /// HTTP request error
  HttpError(Int, String) // status_code, message
  /// JSON parsing error
  JsonError(String)
  /// Authentication error
  AuthError(String)
  /// Rate limit exceeded
  RateLimit(String)
  /// Resource not found
  NotFound(String)
  /// Validation error
  ValidationError(String)
  /// Generic error
  Other(String)
} derive(Show, Eq)

///|
pub typealias Result[T, GitHubError] as GhResult[T]

///|
/// Main GitHub API client
pub struct Octorab {
  /// Client configuration
  config : ClientConfig
  /// HTTP client implementation (placeholder)
  http_client : String // This would be a real HTTP client in practice
} derive(Show, Eq)

///|
/// Create a new GitHub client with default configuration
pub fn Octorab::new() -> Octorab {
  { config: ClientConfig::default(), http_client: "default_http_client" }
}

///|
/// Create a new GitHub client with custom configuration
pub fn Octorab::with_config(config : ClientConfig) -> Octorab {
  { config, http_client: "default_http_client" }
}

///|
/// Set authentication for the client
pub fn Octorab::with_auth(self : Octorab, auth : Auth) -> Octorab {
  { ..self, config: { ..self.config, auth, } }
}



///|
/// Set basic authentication
pub fn Octorab::with_basic_auth(
  self : Octorab,
  username : String,
  password : String,
) -> Octorab {
  self.with_auth(Auth::Basic(username~, password~))
}



///|
/// Set GitHub App authentication
pub fn Octorab::with_app_auth(
  self : Octorab,
  app_id : Int,
  private_key : String,
) -> Octorab {
  self.with_auth(Auth::App({ app_id, private_key }))
}



///|
/// Generic HTTP request method (placeholder implementation)
pub fn[T] Octorab::request(
  self : Octorab,
  method : HttpMethod,
  path : String,
  body : String?,
) -> GhResult[T] {
  // This is a placeholder implementation
  // In a real implementation, this would:
  // 1. Build the full URL
  // 2. Add authentication headers
  // 3. Make the HTTP request
  // 4. Parse the response
  // 5. Handle errors appropriately

  ...

  // Placeholder error for demonstration
  Err(GitHubError::Other("HTTP request not implemented"))
}

///|
/// Convenience method for GET requests
pub fn[T] Octorab::get(self : Octorab, path : String) -> GhResult[T] {
  self.request(HttpMethod::GET, path, None)
}

///|
/// Convenience method for POST requests
pub fn[T] Octorab::post(
  self : Octorab,
  path : String,
  body : String?,
) -> GhResult[T] {
  self.request(HttpMethod::POST, path, body)
}

///|
/// Convenience method for PUT requests  
pub fn[T] Octorab::put(
  self : Octorab,
  path : String,
  body : String?,
) -> GhResult[T] {
  self.request(HttpMethod::PUT, path, body)
}

///|
/// Convenience method for PATCH requests
pub fn[T] Octorab::patch(
  self : Octorab,
  path : String,
  body : String?,
) -> GhResult[T] {
  self.request(HttpMethod::PATCH, path, body)
}

///|
/// Convenience method for DELETE requests
pub fn[T] Octorab::delete(self : Octorab, path : String) -> GhResult[T] {
  self.request(HttpMethod::DELETE, path, None)
}

///|
/// Convenience method for DELETE requests with body
pub fn[T] Octorab::delete_with_body(
  self : Octorab,
  path : String,
  body : String?,
) -> GhResult[T] {
  self.request(HttpMethod::DELETE, path, body)
}

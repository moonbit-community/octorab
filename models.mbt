///|
/// # GitHub API Models
/// 
/// This module contains MoonBit data structures that map to GitHub's JSON API responses.

///|
/// GitHub user/author information
pub struct User {
  /// User ID
  id : Int
  /// User login name
  login : String
  /// Node ID for GraphQL
  node_id : String
  /// Avatar URL
  avatar_url : String
  /// Gravatar ID
  gravatar_id : String
  /// API URL for this user
  url : String
  /// HTML URL for user profile
  html_url : String
  /// Followers URL
  followers_url : String
  /// Following URL template
  following_url : String
  /// Gists URL template
  gists_url : String
  /// Starred repositories URL template
  starred_url : String
  /// Subscriptions URL
  subscriptions_url : String
  /// Organizations URL
  organizations_url : String
  /// Repositories URL
  repos_url : String
  /// Events URL template
  events_url : String
  /// Received events URL
  received_events_url : String
  /// User type (User, Organization, Bot, etc.)
  user_type : String
  /// Whether the user is a site admin
  site_admin : Bool
  /// User's real name (optional)
  name : String?
  /// Company (optional)
  company : String?
  /// Blog URL (optional)
  blog : String?
  /// Location (optional)
  location : String?
  /// Email address (optional)
  email : String?
  /// Whether the user is hireable (optional)
  hireable : Bool?
  /// User biography (optional)
  bio : String?
  /// Twitter username (optional)
  twitter_username : String?
  /// Number of public repositories
  public_repos : Int?
  /// Number of public gists
  public_gists : Int?
  /// Number of followers
  followers : Int?
  /// Number of following
  following : Int?
  /// Account creation date
  created_at : String?
  /// Last update date
  updated_at : String?
} derive(Show, Eq)

///|
/// Simple user information (minimal fields)
pub struct SimpleUser {
  /// User ID
  id : Int
  /// User login name  
  login : String
  /// Node ID for GraphQL
  node_id : String
  /// Avatar URL
  avatar_url : String
  /// HTML URL for user profile
  html_url : String
  /// User type
  user_type : String
  /// Whether the user is a site admin
  site_admin : Bool
} derive(Show, Eq)

///|
/// Repository information
pub struct Repository {
  /// Repository ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Repository name
  name : String
  /// Full name (owner/repo)
  full_name : String
  /// Repository owner
  owner : User
  /// Whether the repository is private
  private : Bool
  /// HTML URL for the repository
  html_url : String
  /// Repository description
  description : String?
  /// Whether this is a fork
  fork : Bool
  /// API URL for this repository
  url : String
  /// Archive URL template
  archive_url : String?
  /// Assignees URL template
  assignees_url : String?
  /// Blobs URL template
  blobs_url : String?
  /// Branches URL template
  branches_url : String?
  /// Collaborators URL template
  collaborators_url : String?
  /// Comments URL template
  comments_url : String?
  /// Commits URL template
  commits_url : String?
  /// Compare URL template
  compare_url : String?
  /// Contents URL template
  contents_url : String?
  /// Contributors URL
  contributors_url : String?
  /// Deployments URL
  deployments_url : String?
  /// Downloads URL
  downloads_url : String?
  /// Events URL
  events_url : String?
  /// Forks URL
  forks_url : String?
  /// Git commits URL template
  git_commits_url : String?
  /// Git refs URL template
  git_refs_url : String?
  /// Git tags URL template
  git_tags_url : String?
  /// Git URL
  git_url : String?
  /// Issue comment URL template
  issue_comment_url : String?
  /// Issue events URL template
  issue_events_url : String?
  /// Issues URL template
  issues_url : String?
  /// Keys URL template
  keys_url : String?
  /// Labels URL template
  labels_url : String?
  /// Languages URL
  languages_url : String?
  /// Merges URL
  merges_url : String?
  /// Milestones URL template
  milestones_url : String?
  /// Notifications URL template
  notifications_url : String?
  /// Pulls URL template
  pulls_url : String?
  /// Releases URL template
  releases_url : String?
  /// SSH URL
  ssh_url : String?
  /// Stargazers URL
  stargazers_url : String?
  /// Statuses URL template
  statuses_url : String?
  /// Subscribers URL
  subscribers_url : String?
  /// Subscription URL
  subscription_url : String?
  /// Tags URL
  tags_url : String?
  /// Teams URL
  teams_url : String?
  /// Trees URL template
  trees_url : String?
  /// Clone URL (HTTPS)
  clone_url : String?
  /// Mirror URL
  mirror_url : String?
  /// Hooks URL
  hooks_url : String?
  /// SVN URL
  svn_url : String?
  /// Homepage URL
  homepage : String?
  /// Primary language
  language : String?
  /// Number of forks
  forks_count : Int
  /// Number of stargazers
  stargazers_count : Int
  /// Number of watchers
  watchers_count : Int
  /// Repository size in KB
  size : Int
  /// Default branch name
  default_branch : String
  /// Number of open issues
  open_issues_count : Int
  /// Whether this is a template repository
  is_template : Bool
  /// Repository topics/tags
  topics : Array[String]
  /// Whether issues are enabled
  has_issues : Bool
  /// Whether projects are enabled
  has_projects : Bool
  /// Whether wiki is enabled
  has_wiki : Bool
  /// Whether pages are enabled
  has_pages : Bool
  /// Whether downloads are enabled
  has_downloads : Bool
  /// Whether the repository is archived
  archived : Bool
  /// Whether the repository is disabled
  disabled : Bool
  /// Repository visibility (public, private, internal)
  visibility : String
  /// Last push date
  pushed_at : String?
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Repository permissions for the authenticated user
  permissions : Permissions?
  /// Whether rebase merge is allowed
  allow_rebase_merge : Bool?
  /// Template repository (if this is created from template)
  template_repository : Repository?
  /// Whether squash merge is allowed
  allow_squash_merge : Bool?
  /// Whether merge commit is allowed
  allow_merge_commit : Bool?
  /// Whether branch updating is allowed
  allow_update_branch : Bool?
  /// Whether forking is allowed
  allow_forking : Bool?
  /// Number of subscribers
  subscribers_count : Int?
  /// Network count
  network_count : Int?
  /// Repository license
  license : License?
  /// Whether auto merge is allowed
  allow_auto_merge : Bool?
  /// Whether to delete branch on merge
  delete_branch_on_merge : Bool?
} derive(Show, Eq)

///|
/// Repository permissions
pub struct Permissions {
  /// Admin permission
  admin : Bool
  /// Push permission
  push : Bool
  /// Pull permission
  pull : Bool
  /// Triage permission
  triage : Bool
  /// Maintain permission
  maintain : Bool
} derive(Show, Eq)

///|
/// License information
pub struct License {
  /// License key
  key : String
  /// License name
  name : String
  /// Node ID for GraphQL
  node_id : String
  /// SPDX ID
  spdx_id : String
  /// License URL
  url : String?
  /// HTML URL
  html_url : String?
  /// License description
  description : String?
  /// Implementation details
  implementation : String?
  /// Permissions granted by this license
  permissions : Array[String]?
  /// Conditions of this license
  conditions : Array[String]?
  /// Limitations of this license
  limitations : Array[String]?
  /// License body text
  body : String?
  /// Whether this is a featured license
  featured : Bool?
} derive(Show, Eq)

///|
/// Issue state
pub enum IssueState {
  Open
  Closed
} derive(Show, Eq)

///|
/// Issue information
pub struct Issue {
  /// Issue ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Issue URL
  url : String
  /// Labels URL
  labels_url : String
  /// Comments URL
  comments_url : String
  /// Events URL
  events_url : String
  /// HTML URL
  html_url : String
  /// Issue number
  number : Int
  /// Issue title
  title : String
  /// Issue description/body
  body : String?
  /// Issue state
  state : IssueState
  /// Whether the issue is locked
  locked : Bool
  /// Reason for locking
  active_lock_reason : String?
  /// Issue assignee
  assignee : User?
  /// Issue assignees
  assignees : Array[User]
  /// Issue author
  user : User
  /// Issue labels
  labels : Array[Label]
  /// Issue milestone
  milestone : Milestone?
  /// Number of comments
  comments : Int
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Close date (if closed)
  closed_at : String?
  /// Author association
  author_association : String
  /// Pull request information (if this issue is a PR)
  pull_request : IssuePullRequest?
  /// Reactions summary
  reactions : Reactions?
} derive(Show, Eq)

///|
/// Label information
pub struct Label {
  /// Label ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Label URL
  url : String
  /// Label name
  name : String
  /// Label description
  description : String?
  /// Label color (hex code)
  color : String
  /// Whether this is a default label
  default : Bool
} derive(Show, Eq)

///|
/// Milestone information
pub struct Milestone {
  /// Milestone URL
  url : String
  /// HTML URL
  html_url : String
  /// Labels URL
  labels_url : String?
  /// Milestone ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Milestone number
  number : Int
  /// Milestone state
  state : String?
  /// Milestone title
  title : String
  /// Milestone description
  description : String?
  /// Milestone creator
  creator : User?
  /// Number of open issues
  open_issues : Int?
  /// Number of closed issues
  closed_issues : Int?
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String?
  /// Close date
  closed_at : String?
  /// Due date
  due_on : String?
} derive(Show, Eq)

///|
/// Pull request reference in issue
pub struct IssuePullRequest {
  /// Pull request URL
  url : String?
  /// HTML URL
  html_url : String?
  /// Diff URL
  diff_url : String?
  /// Patch URL
  patch_url : String?
} derive(Show, Eq)

///|
/// Reactions summary
pub struct Reactions {
  /// Total reaction count
  total_count : Int
  /// +1 reactions
  plus_one : Int
  /// -1 reactions
  minus_one : Int
  /// Laugh reactions
  laugh : Int
  /// Confused reactions
  confused : Int
  /// Heart reactions
  heart : Int
  /// Hooray reactions
  hooray : Int
  /// Eyes reactions
  eyes : Int
  /// Rocket reactions
  rocket : Int
} derive(Show, Eq)

///|
/// Pull request state
pub enum PullRequestState {
  Open
  Closed
  Merged
} derive(Show, Eq)

///|
/// Pull request information
pub struct PullRequest {
  /// Pull request ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Pull request URL
  url : String
  /// HTML URL
  html_url : String
  /// Diff URL
  diff_url : String
  /// Patch URL
  patch_url : String
  /// Issue URL
  issue_url : String
  /// Commits URL
  commits_url : String
  /// Review comments URL
  review_comments_url : String
  /// Review comment URL template
  review_comment_url : String
  /// Comments URL
  comments_url : String
  /// Statuses URL
  statuses_url : String
  /// Pull request number
  number : Int
  /// Pull request title
  title : String
  /// Pull request description/body
  body : String?
  /// Pull request state
  state : PullRequestState
  /// Whether the pull request is locked
  locked : Bool
  /// Pull request author
  user : User
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Close date (if closed)
  closed_at : String?
  /// Merge date (if merged)
  merged_at : String?
  /// Merge commit SHA
  merge_commit_sha : String?
  /// Pull request assignee
  assignee : User?
  /// Pull request assignees
  assignees : Array[User]
  /// Requested reviewers
  requested_reviewers : Array[User]
  /// Requested team reviewers
  requested_teams : Array[Team]
  /// Pull request labels
  labels : Array[Label]
  /// Pull request milestone
  milestone : Milestone?
  /// Whether this is a draft pull request
  draft : Bool
  /// Head branch information
  head : PullRequestBranch
  /// Base branch information
  base : PullRequestBranch
  /// Merge state
  mergeable : Bool?
  /// Rebaseable state
  rebaseable : Bool?
  /// Mergeable state
  mergeable_state : String?
  /// User who merged the pull request
  merged_by : User?
  /// Number of comments
  comments : Int
  /// Number of review comments
  review_comments : Int
  /// Whether maintainer can modify
  maintainer_can_modify : Bool
  /// Number of commits
  commits : Int
  /// Number of additions
  additions : Int
  /// Number of deletions
  deletions : Int
  /// Number of changed files
  changed_files : Int
  /// Author association
  author_association : String
  /// Whether auto merge is enabled
  auto_merge : Bool?
  /// Reactions summary
  reactions : Reactions?
} derive(Show, Eq)

///|
/// Pull request branch information
pub struct PullRequestBranch {
  /// Branch label
  label : String
  /// Branch reference
  ref : String
  /// Commit SHA
  sha : String
  /// Repository owner
  user : User
  /// Repository information
  repo : Repository?
} derive(Show, Eq)

///|
/// Team information
pub struct Team {
  /// Team ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Team URL
  url : String
  /// HTML URL
  html_url : String
  /// Team name
  name : String
  /// Team slug
  slug : String
  /// Team description
  description : String?
  /// Team privacy level
  privacy : String
  /// Team permission level
  permission : String
  /// Members URL
  members_url : String
  /// Repositories URL
  repositories_url : String
} derive(Show, Eq)

///|
/// Git reference information
pub struct GitRef {
  /// Reference name
  ref : String
  /// Node ID for GraphQL
  node_id : String
  /// Reference URL
  url : String
  /// Object information
  object : GitObject
} derive(Show, Eq)

///|
/// Git object information
pub struct GitObject {
  /// Object SHA
  sha : String
  /// Object type (commit, tree, blob, tag)
  object_type : String
  /// Object URL
  url : String
} derive(Show, Eq)

///|
/// Commit information
pub struct Commit {
  /// Commit SHA
  sha : String
  /// Node ID for GraphQL
  node_id : String
  /// Commit URL
  url : String
  /// HTML URL
  html_url : String
  /// Comments URL
  comments_url : String
  /// Commit details
  commit : GitCommit
  /// Commit author (GitHub user)
  author : User?
  /// Commit committer (GitHub user)  
  committer : User?
  /// Parent commits
  parents : Array[CommitParent]
  /// Commit stats
  stats : CommitStats?
  /// Changed files
  files : Array[CommitFile]?
} derive(Show, Eq)

///|
/// Git commit details
pub struct GitCommit {
  /// Commit author
  author : GitUser
  /// Commit committer
  committer : GitUser
  /// Commit message
  message : String
  /// Tree information
  tree : GitObject
  /// Comment count
  comment_count : Int
  /// Verification information
  verification : Verification?
} derive(Show, Eq)

///|
/// Git user information (name, email, date)
pub struct GitUser {
  /// User name
  name : String
  /// User email
  email : String
  /// Date
  date : String
} derive(Show, Eq)

///|
/// Commit parent reference
pub struct CommitParent {
  /// Parent commit SHA
  sha : String
  /// Parent commit URL
  url : String
  /// Parent commit HTML URL
  html_url : String
} derive(Show, Eq)

///|
/// Commit statistics
pub struct CommitStats {
  /// Total changes
  total : Int
  /// Additions
  additions : Int
  /// Deletions
  deletions : Int
} derive(Show, Eq)

///|
/// Commit file changes
pub struct CommitFile {
  /// File SHA
  sha : String?
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
/// Verification information for commits
pub struct Verification {
  /// Whether the commit is verified
  verified : Bool
  /// Verification reason
  reason : String
  /// Signature
  signature : String?
  /// Payload
  payload : String?
} derive(Show, Eq)

///|
/// Organization information
pub struct Organization {
  /// Organization ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Organization login
  login : String
  /// Organization URL
  url : String
  /// Repositories URL
  repos_url : String
  /// Events URL
  events_url : String
  /// Hooks URL
  hooks_url : String
  /// Issues URL
  issues_url : String
  /// Members URL
  members_url : String
  /// Public members URL
  public_members_url : String
  /// Avatar URL
  avatar_url : String
  /// Organization description
  description : String?
  /// Display name
  name : String?
  /// Company
  company : String?
  /// Blog URL
  blog : String?
  /// Location
  location : String?
  /// Email
  email : String?
  /// Twitter username
  twitter_username : String?
  /// Whether the organization has organization projects
  has_organization_projects : Bool
  /// Whether the organization has repository projects
  has_repository_projects : Bool
  /// Public repositories count
  public_repos : Int
  /// Public gists count
  public_gists : Int
  /// Followers count
  followers : Int
  /// Following count
  following : Int
  /// HTML URL
  html_url : String
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Organization type
  org_type : String
} derive(Show, Eq)

///|
/// Release information
pub struct Release {
  /// Release ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Release URL
  url : String
  /// HTML URL
  html_url : String
  /// Assets URL
  assets_url : String
  /// Upload URL template
  upload_url : String
  /// Tarball URL
  tarball_url : String?
  /// Zipball URL
  zipball_url : String?
  /// Release tag name
  tag_name : String
  /// Target branch/commit
  target_commitish : String
  /// Release name
  name : String?
  /// Release description/body
  body : String?
  /// Whether this is a draft
  draft : Bool
  /// Whether this is a prerelease
  prerelease : Bool
  /// Creation date
  created_at : String
  /// Publication date
  published_at : String?
  /// Release author
  author : User
  /// Release assets
  assets : Array[ReleaseAsset]
} derive(Show, Eq)

///|
/// Release asset information
pub struct ReleaseAsset {
  /// Asset ID
  id : Int
  /// Node ID for GraphQL
  node_id : String
  /// Asset URL
  url : String
  /// Asset name
  name : String
  /// Asset label
  label : String?
  /// Asset uploader
  uploader : User
  /// Content type
  content_type : String
  /// Asset state
  state : String
  /// Asset size in bytes
  size : Int
  /// Download count
  download_count : Int
  /// Creation date
  created_at : String
  /// Last update date
  updated_at : String
  /// Browser download URL
  browser_download_url : String
} derive(Show, Eq)

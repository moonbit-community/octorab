///|
pub(all) enum IssueState {
  Open
  Closed
  All
} derive(Show, Eq, ToJson)

///|
pub fn IssueState::as_query(self : IssueState) -> String {
  match self {
    Open => "open"
    Closed => "closed"
    All => "all"
  }
}

///|
pub(all) enum SortDirection {
  Asc
  Desc
} derive(Show, Eq, ToJson)

///|
pub fn SortDirection::as_query(self : SortDirection) -> String {
  match self {
    Asc => "asc"
    Desc => "desc"
  }
}

///|
pub(all) enum RepoSort {
  Stars
  Forks
  Updated
} derive(Show, Eq, ToJson)

///|
pub fn RepoSort::as_query(self : RepoSort) -> String {
  match self {
    Stars => "stars"
    Forks => "forks"
    Updated => "updated"
  }
}

///|
pub(all) enum PullSort {
  Created
  Updated
  Popularity
  LongRunning
} derive(Show, Eq, ToJson)

///|
pub fn PullSort::as_query(self : PullSort) -> String {
  match self {
    Created => "created"
    Updated => "updated"
    Popularity => "popularity"
    LongRunning => "long-running"
  }
}

///|
pub(all) enum OrgRepoType {
  All
  Public
  Private
  Forks
  Sources
  Member
  Internal
} derive(Show, Eq, ToJson)

///|
pub fn OrgRepoType::as_query(self : OrgRepoType) -> String {
  match self {
    All => "all"
    Public => "public"
    Private => "private"
    Forks => "forks"
    Sources => "sources"
    Member => "member"
    Internal => "internal"
  }
}

///|
pub(all) enum OrgRepoSort {
  Created
  Updated
  Pushed
  FullName
} derive(Show, Eq, ToJson)

///|
pub fn OrgRepoSort::as_query(self : OrgRepoSort) -> String {
  match self {
    Created => "created"
    Updated => "updated"
    Pushed => "pushed"
    FullName => "full_name"
  }
}

///|
pub(all) enum OrgMemberFilter {
  All
  TwoFactorDisabled
} derive(Show, Eq, ToJson)

///|
pub fn OrgMemberFilter::as_query(self : OrgMemberFilter) -> String {
  match self {
    All => "all"
    TwoFactorDisabled => "2fa_disabled"
  }
}

///|
pub(all) enum OrgMemberRole {
  All
  Admin
  Member
} derive(Show, Eq, ToJson)

///|
pub fn OrgMemberRole::as_query(self : OrgMemberRole) -> String {
  match self {
    All => "all"
    Admin => "admin"
    Member => "member"
  }
}

///|
pub(all) enum IssueState {
  Open
  Closed
  All
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

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
} derive(Eq, ToJson)

///|
pub fn OrgMemberRole::as_query(self : OrgMemberRole) -> String {
  match self {
    All => "all"
    Admin => "admin"
    Member => "member"
  }
}

///|
pub impl Show for IssueState with fn output(self, logger) {
  match self {
    Open => logger.write_string("Open")
    Closed => logger.write_string("Closed")
    All => logger.write_string("All")
  }
}

///|
pub impl Show for SortDirection with fn output(self, logger) {
  match self {
    Asc => logger.write_string("Asc")
    Desc => logger.write_string("Desc")
  }
}

///|
pub impl Show for RepoSort with fn output(self, logger) {
  match self {
    Stars => logger.write_string("Stars")
    Forks => logger.write_string("Forks")
    Updated => logger.write_string("Updated")
  }
}

///|
pub impl Show for PullSort with fn output(self, logger) {
  match self {
    Created => logger.write_string("Created")
    Updated => logger.write_string("Updated")
    Popularity => logger.write_string("Popularity")
    LongRunning => logger.write_string("LongRunning")
  }
}

///|
pub impl Show for OrgRepoType with fn output(self, logger) {
  match self {
    All => logger.write_string("All")
    Public => logger.write_string("Public")
    Private => logger.write_string("Private")
    Forks => logger.write_string("Forks")
    Sources => logger.write_string("Sources")
    Member => logger.write_string("Member")
    Internal => logger.write_string("Internal")
  }
}

///|
pub impl Show for OrgRepoSort with fn output(self, logger) {
  match self {
    Created => logger.write_string("Created")
    Updated => logger.write_string("Updated")
    Pushed => logger.write_string("Pushed")
    FullName => logger.write_string("FullName")
  }
}

///|
pub impl Show for OrgMemberFilter with fn output(self, logger) {
  match self {
    All => logger.write_string("All")
    TwoFactorDisabled => logger.write_string("TwoFactorDisabled")
  }
}

///|
pub impl Show for OrgMemberRole with fn output(self, logger) {
  match self {
    All => logger.write_string("All")
    Admin => logger.write_string("Admin")
    Member => logger.write_string("Member")
  }
}

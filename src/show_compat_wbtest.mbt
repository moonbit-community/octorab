///|
test "legacy Show compatibility" {
  assert_eq(Show::to_string(IssueState::Open), "Open")
  assert_eq(Show::to_string(IssueState::Closed), "Closed")
  assert_eq(Show::to_string(IssueState::All), "All")
  assert_eq(Show::to_string(SortDirection::Asc), "Asc")
  assert_eq(Show::to_string(SortDirection::Desc), "Desc")
  assert_eq(Show::to_string(RepoSort::Stars), "Stars")
  assert_eq(Show::to_string(RepoSort::Forks), "Forks")
  assert_eq(Show::to_string(RepoSort::Updated), "Updated")
  assert_eq(Show::to_string(PullSort::Created), "Created")
  assert_eq(Show::to_string(PullSort::Updated), "Updated")
  assert_eq(Show::to_string(PullSort::Popularity), "Popularity")
  assert_eq(Show::to_string(PullSort::LongRunning), "LongRunning")
  assert_eq(Show::to_string(OrgRepoType::All), "All")
  assert_eq(Show::to_string(OrgRepoType::Public), "Public")
  assert_eq(Show::to_string(OrgRepoType::Private), "Private")
  assert_eq(Show::to_string(OrgRepoType::Forks), "Forks")
  assert_eq(Show::to_string(OrgRepoType::Sources), "Sources")
  assert_eq(Show::to_string(OrgRepoType::Member), "Member")
  assert_eq(Show::to_string(OrgRepoType::Internal), "Internal")
  assert_eq(Show::to_string(OrgRepoSort::Created), "Created")
  assert_eq(Show::to_string(OrgRepoSort::Updated), "Updated")
  assert_eq(Show::to_string(OrgRepoSort::Pushed), "Pushed")
  assert_eq(Show::to_string(OrgRepoSort::FullName), "FullName")
  assert_eq(Show::to_string(OrgMemberFilter::All), "All")
  assert_eq(
    Show::to_string(OrgMemberFilter::TwoFactorDisabled),
    "TwoFactorDisabled",
  )
  assert_eq(Show::to_string(OrgMemberRole::All), "All")
  assert_eq(Show::to_string(OrgMemberRole::Admin), "Admin")
  assert_eq(Show::to_string(OrgMemberRole::Member), "Member")
  assert_eq(Show::to_string(Auth::Token("raw\"text")), "Token(raw\"text)")
  assert_eq(Show::to_string(Auth::Bearer("raw\"text")), "Bearer(raw\"text)")
  assert_eq(
    Show::to_string(User::{
      login: "raw\"text",
      id: 7,
      node_id: Some("raw\"text"),
      avatar_url: Some("raw\"text"),
      html_url: Some("raw\"text"),
    }),
    "{login: raw\"text, id: 7, node_id: Some(raw\"text), avatar_url: Some(raw\"text), html_url: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(User::{
      login: "raw\"text",
      id: 7,
      node_id: None,
      avatar_url: None,
      html_url: None,
    }),
    "{login: raw\"text, id: 7, node_id: None, avatar_url: None, html_url: None}",
  )
  assert_eq(
    Show::to_string(Repository::{
      id: 7,
      name: "raw\"text",
      full_name: Some("raw\"text"),
      private: Some(true),
      owner: Some(User::{
        login: "raw\"text",
        id: 7,
        node_id: Some("raw\"text"),
        avatar_url: Some("raw\"text"),
        html_url: Some("raw\"text"),
      }),
      html_url: Some("raw\"text"),
      description: Some("raw\"text"),
      fork: Some(true),
      stargazers_count: Some(7),
      watchers_count: Some(7),
      language: Some("raw\"text"),
      default_branch: Some("raw\"text"),
    }),
    "{id: 7, name: raw\"text, full_name: Some(raw\"text), private: Some(true), owner: Some({login: raw\"text, id: 7, node_id: Some(raw\"text), avatar_url: Some(raw\"text), html_url: Some(raw\"text)}), html_url: Some(raw\"text), description: Some(raw\"text), fork: Some(true), stargazers_count: Some(7), watchers_count: Some(7), language: Some(raw\"text), default_branch: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(Repository::{
      id: 7,
      name: "raw\"text",
      full_name: None,
      private: None,
      owner: None,
      html_url: None,
      description: None,
      fork: None,
      stargazers_count: None,
      watchers_count: None,
      language: None,
      default_branch: None,
    }),
    "{id: 7, name: raw\"text, full_name: None, private: None, owner: None, html_url: None, description: None, fork: None, stargazers_count: None, watchers_count: None, language: None, default_branch: None}",
  )
  assert_eq(
    Show::to_string(PullRequestLinks::{
      url: Some("raw\"text"),
      html_url: Some("raw\"text"),
      diff_url: Some("raw\"text"),
      patch_url: Some("raw\"text"),
    }),
    "{url: Some(raw\"text), html_url: Some(raw\"text), diff_url: Some(raw\"text), patch_url: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(PullRequestLinks::{
      url: None,
      html_url: None,
      diff_url: None,
      patch_url: None,
    }),
    "{url: None, html_url: None, diff_url: None, patch_url: None}",
  )
  assert_eq(
    Show::to_string(Issue::{
      id: 7,
      number: 7,
      title: "raw\"text",
      state: Some("raw\"text"),
      user: Some(User::{
        login: "raw\"text",
        id: 7,
        node_id: Some("raw\"text"),
        avatar_url: Some("raw\"text"),
        html_url: Some("raw\"text"),
      }),
      body: Some("raw\"text"),
      comments: Some(7),
      html_url: Some("raw\"text"),
      pull_request: Some(PullRequestLinks::{
        url: Some("raw\"text"),
        html_url: Some("raw\"text"),
        diff_url: Some("raw\"text"),
        patch_url: Some("raw\"text"),
      }),
    }),
    "{id: 7, number: 7, title: raw\"text, state: Some(raw\"text), user: Some({login: raw\"text, id: 7, node_id: Some(raw\"text), avatar_url: Some(raw\"text), html_url: Some(raw\"text)}), body: Some(raw\"text), comments: Some(7), html_url: Some(raw\"text), pull_request: Some({url: Some(raw\"text), html_url: Some(raw\"text), diff_url: Some(raw\"text), patch_url: Some(raw\"text)})}",
  )
  assert_eq(
    Show::to_string(Issue::{
      id: 7,
      number: 7,
      title: "raw\"text",
      state: None,
      user: None,
      body: None,
      comments: None,
      html_url: None,
      pull_request: None,
    }),
    "{id: 7, number: 7, title: raw\"text, state: None, user: None, body: None, comments: None, html_url: None, pull_request: None}",
  )
  assert_eq(
    Show::to_string(Organization::{
      login: "raw\"text",
      id: 7,
      name: Some("raw\"text"),
      description: Some("raw\"text"),
      html_url: Some("raw\"text"),
      repos_url: Some("raw\"text"),
    }),
    "{login: raw\"text, id: 7, name: Some(raw\"text), description: Some(raw\"text), html_url: Some(raw\"text), repos_url: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(Organization::{
      login: "raw\"text",
      id: 7,
      name: None,
      description: None,
      html_url: None,
      repos_url: None,
    }),
    "{login: raw\"text, id: 7, name: None, description: None, html_url: None, repos_url: None}",
  )
  assert_eq(
    Show::to_string(PullRequest::{
      id: 7,
      number: 7,
      title: "raw\"text",
      state: Some("raw\"text"),
      user: Some(User::{
        login: "raw\"text",
        id: 7,
        node_id: Some("raw\"text"),
        avatar_url: Some("raw\"text"),
        html_url: Some("raw\"text"),
      }),
      body: Some("raw\"text"),
      html_url: Some("raw\"text"),
      diff_url: Some("raw\"text"),
      patch_url: Some("raw\"text"),
      merged_at: Some("raw\"text"),
    }),
    "{id: 7, number: 7, title: raw\"text, state: Some(raw\"text), user: Some({login: raw\"text, id: 7, node_id: Some(raw\"text), avatar_url: Some(raw\"text), html_url: Some(raw\"text)}), body: Some(raw\"text), html_url: Some(raw\"text), diff_url: Some(raw\"text), patch_url: Some(raw\"text), merged_at: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(PullRequest::{
      id: 7,
      number: 7,
      title: "raw\"text",
      state: None,
      user: None,
      body: None,
      html_url: None,
      diff_url: None,
      patch_url: None,
      merged_at: None,
    }),
    "{id: 7, number: 7, title: raw\"text, state: None, user: None, body: None, html_url: None, diff_url: None, patch_url: None, merged_at: None}",
  )
  assert_eq(
    Show::to_string(PullRequestFile::{
      sha: "raw\"text",
      filename: "raw\"text",
      status: Some("raw\"text"),
      additions: Some(7),
      deletions: Some(7),
      changes: Some(7),
      patch: Some("raw\"text"),
    }),
    "{sha: raw\"text, filename: raw\"text, status: Some(raw\"text), additions: Some(7), deletions: Some(7), changes: Some(7), patch: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(PullRequestFile::{
      sha: "raw\"text",
      filename: "raw\"text",
      status: None,
      additions: None,
      deletions: None,
      changes: None,
      patch: None,
    }),
    "{sha: raw\"text, filename: raw\"text, status: None, additions: None, deletions: None, changes: None, patch: None}",
  )
  assert_eq(
    Show::to_string(PageLinks::{
      next: Some("raw\"text"),
      prev: Some("raw\"text"),
      first: Some("raw\"text"),
      last: Some("raw\"text"),
    }),
    "{next: Some(raw\"text), prev: Some(raw\"text), first: Some(raw\"text), last: Some(raw\"text)}",
  )
  assert_eq(
    Show::to_string(PageLinks::{
      next: None,
      prev: None,
      first: None,
      last: None,
    }),
    "{next: None, prev: None, first: None, last: None}",
  )
  assert_eq(
    Show::to_string(GitHubError::{
      status: 7,
      message: "raw\"text",
      documentation_url: Some("raw\"text"),
      errors: Some([
        Json::object({
          "field": Json::array([
            Json::null(),
            Json::boolean(true),
            Json::boolean(false),
            Json::string("raw"),
            Json::number(1.5, repr="1.50"),
          ]),
        }),
      ]),
    }),
    "{status: 7, message: raw\"text, documentation_url: Some(raw\"text), errors: Some([Object({field: Array([Null, True, False, String(raw), Number(1.5, repr=Some(1.50))])})])}",
  )
  assert_eq(
    Show::to_string(GitHubError::{
      status: 7,
      message: "raw\"text",
      documentation_url: None,
      errors: None,
    }),
    "{status: 7, message: raw\"text, documentation_url: None, errors: None}",
  )
  assert_eq(
    Show::to_string(OctorabError::InvalidUrl("raw\"text")),
    "InvalidUrl(raw\"text)",
  )
  assert_eq(
    Show::to_string(
      OctorabError::HttpError(GitHubError::{
        status: 7,
        message: "raw\"text",
        documentation_url: Some("raw\"text"),
        errors: Some([
          Json::object({
            "field": Json::array([
              Json::null(),
              Json::boolean(true),
              Json::boolean(false),
              Json::string("raw"),
              Json::number(1.5, repr="1.50"),
            ]),
          }),
        ]),
      }),
    ),
    "HttpError({status: 7, message: raw\"text, documentation_url: Some(raw\"text), errors: Some([Object({field: Array([Null, True, False, String(raw), Number(1.5, repr=Some(1.50))])})])})",
  )
}

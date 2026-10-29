///|
pub extend Auth with Eq::{not_equal, equal}

///|
pub extend Auth with Show::{to_string, output}

///|
pub extend Auth with ToJson::{to_json}

///|
pub extend GitHubError with Eq::{not_equal, equal}

///|
pub extend GitHubError with Show::{to_string, output}

///|
pub extend GitHubError with ToJson::{to_json}

///|
pub extend Issue with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend Issue with Eq::{not_equal, equal}

///|
pub extend Issue with Show::{to_string, output}

///|
pub extend Issue with ToJson::{to_json}

///|
pub extend IssueState with Eq::{not_equal, equal}

///|
pub extend IssueState with Show::{to_string, output}

///|
pub extend IssueState with ToJson::{to_json}

///|
pub extend OctorabError with Show::{to_string, output}

///|
pub extend OctorabError with ToJson::{to_json}

///|
pub extend OrgMemberFilter with Eq::{not_equal, equal}

///|
pub extend OrgMemberFilter with Show::{to_string, output}

///|
pub extend OrgMemberFilter with ToJson::{to_json}

///|
pub extend OrgMemberRole with Eq::{not_equal, equal}

///|
pub extend OrgMemberRole with Show::{to_string, output}

///|
pub extend OrgMemberRole with ToJson::{to_json}

///|
pub extend OrgRepoSort with Eq::{not_equal, equal}

///|
pub extend OrgRepoSort with Show::{to_string, output}

///|
pub extend OrgRepoSort with ToJson::{to_json}

///|
pub extend OrgRepoType with Eq::{not_equal, equal}

///|
pub extend OrgRepoType with Show::{to_string, output}

///|
pub extend OrgRepoType with ToJson::{to_json}

///|
pub extend Organization with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend Organization with Eq::{not_equal, equal}

///|
pub extend Organization with Show::{to_string, output}

///|
pub extend Organization with ToJson::{to_json}

///|
pub extend PageLinks with Eq::{not_equal, equal}

///|
pub extend PageLinks with Show::{to_string, output}

///|
pub extend PageLinks with ToJson::{to_json}

///|
pub extend PullRequest with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend PullRequest with Eq::{not_equal, equal}

///|
pub extend PullRequest with Show::{to_string, output}

///|
pub extend PullRequest with ToJson::{to_json}

///|
pub extend PullRequestFile with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend PullRequestFile with Eq::{not_equal, equal}

///|
pub extend PullRequestFile with Show::{to_string, output}

///|
pub extend PullRequestFile with ToJson::{to_json}

///|
pub extend PullRequestLinks with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend PullRequestLinks with Eq::{not_equal, equal}

///|
pub extend PullRequestLinks with Show::{to_string, output}

///|
pub extend PullRequestLinks with ToJson::{to_json}

///|
pub extend PullSort with Eq::{not_equal, equal}

///|
pub extend PullSort with Show::{to_string, output}

///|
pub extend PullSort with ToJson::{to_json}

///|
pub extend RepoSort with Eq::{not_equal, equal}

///|
pub extend RepoSort with Show::{to_string, output}

///|
pub extend RepoSort with ToJson::{to_json}

///|
pub extend Repository with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend Repository with Eq::{not_equal, equal}

///|
pub extend Repository with Show::{to_string, output}

///|
pub extend Repository with ToJson::{to_json}

///|
pub extend SearchPage with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend SortDirection with Eq::{not_equal, equal}

///|
pub extend SortDirection with Show::{to_string, output}

///|
pub extend SortDirection with ToJson::{to_json}

///|
pub extend User with @moonbitlang/core/json.FromJson::{from_json}

///|
pub extend User with Eq::{not_equal, equal}

///|
pub extend User with Show::{to_string, output}

///|
pub extend User with ToJson::{to_json}

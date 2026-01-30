///|
let test_owner : String = "moonbit-community"

///|
let test_repo : String = "octorab_test"

///|
fn test_client() -> @octorab.Octorab {
  @octorab.Octorab::default()
}

///|
fn repo_handler(client : @octorab.Octorab) -> @octorab.ReposHandler {
  client.repos(test_owner, test_repo)
}

///|
fn is_json_string_field(item : Json, field : String) -> Bool {
  match item {
    Json::Object(map) =>
      match map.get(field) {
        Some(Json::String(value)) => value != ""
        _ => false
      }
    _ => false
  }
}

///|
fn is_json_number_field(item : Json, field : String) -> Bool {
  match item {
    Json::Object(map) =>
      match map.get(field) {
        Some(Json::Number(_, ..)) => true
        _ => false
      }
    _ => false
  }
}

///|
fn is_json_object_number_map(value : Json) -> Bool {
  match value {
    Json::Object(map) => {
      for _, v in map {
        guard v is Json::Number(_, ..) else { return false }
      }
      true
    }
    _ => false
  }
}

///|
async test "repos get repository basics" {
  let repo = repo_handler(test_client()).get()
  assert_eq(repo.name, test_repo)
  let expected_full_name = "\{test_owner}/\{test_repo}"
  guard repo.full_name is Some(full_name) && full_name == expected_full_name else {
    fail("expected full_name \{expected_full_name}")
  }
  guard repo.owner is Some(owner) else { fail("expected owner") }
  assert_eq(owner.login, test_owner)
  guard repo.html_url is Some(url) else { fail("expected html_url") }
  assert_eq(url, "https://github.com/\{test_owner}/\{test_repo}")
}

///|
async test "repos list languages returns number map" {
  let languages = repo_handler(test_client()).list_languages()
  guard is_json_object_number_map(languages) else {
    fail("expected number map for languages")
  }
}

///|
async test "repos list branches page structure" {
  let page = repo_handler(test_client()).list_branches(per_page=5, page=1)
  guard page.total_count is None && page.incomplete_results is None else {
    fail("expected list endpoint without search metadata")
  }
  for item in page.items {
    guard is_json_string_field(item, "name") else {
      fail("expected branch name field")
    }
  }
}

///|
async test "repos list tags page structure" {
  let page = repo_handler(test_client()).list_tags(per_page=5, page=1)
  guard page.total_count is None && page.incomplete_results is None else {
    fail("expected list endpoint without search metadata")
  }
  for item in page.items {
    guard is_json_string_field(item, "name") else {
      fail("expected tag name field")
    }
  }
}

///|
async test "repos list releases page structure" {
  let page = repo_handler(test_client()).list_releases(per_page=5, page=1)
  guard page.total_count is None && page.incomplete_results is None else {
    fail("expected list endpoint without search metadata")
  }
  for item in page.items {
    guard is_json_number_field(item, "id") else {
      fail("expected release id field")
    }
  }
}

///|
async test "repos list contributors page structure" {
  let page = repo_handler(test_client()).list_contributors(per_page=5, page=1)
  guard page.total_count is None && page.incomplete_results is None else {
    fail("expected list endpoint without search metadata")
  }
  for item in page.items {
    guard is_json_string_field(item, "login") else {
      fail("expected contributor login field")
    }
  }
}

///|
async test "search repositories finds octorab_test" {
  let query = "\{test_repo} org:\{test_owner}"
  let page = test_client().search_repositories(query, per_page=1, page=1)
  guard page.total_count is Some(count) && count >= 1 else {
    fail("expected at least one search result")
  }
  guard page.items is [first, ..] else { fail("expected search results") }
  assert_eq(first.name, test_repo)
  guard first.full_name is Some(full_name) else { fail("expected full_name") }
  assert_eq(full_name, "\{test_owner}/\{test_repo}")
}

///|
async test "repos get contents missing path returns 404" {
  let result : Result[Json, Error] = try? repo_handler(test_client()).get_contents(
    path="__octorab_missing__",
  )
  match result {
    Err(@octorab.OctorabError::HttpError(err)) => assert_eq(err.status, 404)
    Ok(_) => fail("expected http error")
    Err(_) => fail("unexpected error type")
  }
}

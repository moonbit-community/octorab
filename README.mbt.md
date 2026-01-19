# octorab

Octorab is a third party GitHub API client for MoonBit.
It mirrors the spirit of the Rust `octocrab` client while embracing MoonBit
idioms (optional labeled parameters instead of builder chains, and async
functions for HTTP calls).

> 注意：当前 HTTP 实现依赖 `moonbitlang/async/http`，请使用 `--target native` 运行/测试。

## Quick start

```mbt nocheck
///|
async test {
  let crab = Octorab::default()
    .with_token("ghp_your_token_here")

  let repo = crab.repos("octocat", "Hello-World").get()
  inspect(repo.name, content="Hello-World")
}
```

## Listing issues (paged)

```mbt nocheck
///|
 
async test {
  let crab = Octorab::default()

  let page = crab
    .issues("octocat", "Hello-World")
    .list(state=IssueState::Open, per_page=10)

  inspect(page.items.length(), content="10")
}
```

## Fetching all pages

```mbt nocheck
///|
 
async test {
  let crab = Octorab::default()
  let first = crab.search_repositories("language:moonbit", per_page=30)
  let all_items = crab.all_pages(first)
  inspect(all_items.length() >= 30, content="true")
}
```

## Low-level HTTP API

Octorab exposes raw HTTP helpers similar to `octocrab`'s `_get`/`_post`:

```mbt nocheck
///|
 
async test {
  let crab = Octorab::default()
  let (_response, body) = crab.get_raw("/rate_limit")
  let json = body.json()
  inspect(json is Json::Object(_), content="true")
}
```

# MoonBit GitHub API Library

A modern, type-safe GitHub API client library for MoonBit. Inspired by the design of Rust's octocrab library, this library provides a clean and intuitive interface for interacting with GitHub's REST API.

## Features

- **Type-safe**: All API responses are mapped to strongly-typed MoonBit structures
- **Comprehensive**: Covers major GitHub API endpoints including repositories, issues, pull requests, and users
- **Authentication**: Support for multiple authentication methods (Personal Access Tokens, OAuth, GitHub Apps)
- **Easy to use**: Intuitive builder-pattern API design
- **Well-documented**: Extensive documentation with examples

## Installation

Add this to your `moon.mod.json`:

```json
{
  "deps": {
    "moonbitlang/github-api": "*"
  }
}
```

## Quick Start

Here's a simple example to get you started:

```moonbit
///|
test "basic usage" {
  // Create a client with authentication
  let client = Octorab::new().with_token("your_personal_access_token")

  // Get repository information
  let repo_result = client.repositories("octocat", "Hello-World").get()
  // In a real implementation, this would return actual data

  // Create an issue
  let issue_params = CreateIssueParams::{
    title: "Found a bug",
    body: Some("There seems to be an issue with the login system"),
    assignee: None,
    milestone: None,
    labels: Some(["bug", "high-priority"]),
    assignees: None,
  }
  let issue_result = client
    .repositories("octocat", "Hello-World")
    .issues()
    .create(issue_params)

}
```

## Authentication

### Personal Access Token

```moonbit
///|
test "personal access token auth" {
  let client = Octorab::new().with_token("ghp_xxxxxxxxxxxxxxxxxxxx")
  // Use the client...
}
```

### Basic Authentication

```moonbit
///|
test "basic auth" {
  let client = Octorab::new().with_basic_auth("username", "password")
  // Note: Basic auth with password is deprecated by GitHub
}
```

### OAuth Token

```moonbit
///|
test "oauth auth" {
  let client = Octorab::new().with_oauth("oauth_token")
  // Use the client...
}
```

### GitHub App Authentication

```moonbit
///|
test "github app auth" {
  let client = Octorab::new().with_app_auth(
    12345, "-----BEGIN RSA PRIVATE KEY-----\n...",
  )
  // Use the client...
}
```

## Repository Operations

### Getting Repository Information

```moonbit
///|
test "get repository" {
  let client = Octorab::new().with_token("your_token")

  // Get repository details
  let repo_result = client.repositories("microsoft", "vscode").get()

  // Get repository README
  let readme_result = client.repositories("microsoft", "vscode").get_readme()

  // List repository languages
  let languages_result = client
    .repositories("microsoft", "vscode")
    .list_languages()

}
```

### Repository Content Operations

```moonbit
///|
test "repository content" {
  let client = Octorab::new().with_token("your_token")
  let repo = client.repositories("octocat", "Hello-World")

  // Get file contents
  let content_result = repo.get_contents("README.md")

  // Create a new file
  let create_result = repo.create_or_update_file(
    "docs/new-doc.md", "Add new documentation", "# New Documentation\n\nThis is a new file.",
  )

  // Delete a file
  let delete_result = repo.delete_file(
    "old-file.txt", "Remove old file", "file_sha_here",
  )

}
```

### Repository Collaboration

```moonbit
///|
test "repository collaboration" {
  let client = Octorab::new().with_token("your_token")
  let repo = client.repositories("octocat", "Hello-World")

  // Fork the repository
  let fork_result = repo.fork()

  // Star the repository
  let star_result = repo.star()

  // Check if starred
  let is_starred_result = repo.is_starred()

  // Unstar the repository
  let unstar_result = repo.unstar()

}
```

## Issue Management

### Listing and Getting Issues

```moonbit
///|
test "issue operations" {
  let client = Octorab::new().with_token("your_token")
  let issues = client.repositories("octocat", "Hello-World").issues()

  // List all open issues
  let list_params = ListIssuesParams::default()
  let issues_result = issues.list(list_params)

  // Get a specific issue
  let issue_result = issues.get(42)

}
```

### Creating and Updating Issues

```moonbit
///|
test "create and update issues" {
  let client = Octorab::new().with_token("your_token")
  let issues = client.repositories("octocat", "Hello-World").issues()

  // Create a new issue
  let create_params = {
    title: "New feature request",
    body: Some("It would be great if we could add feature X"),
    assignee: Some("octocat"),
    milestone: None,
    labels: Some(["enhancement", "help wanted"]),
    assignees: Some(["octocat", "defunkt"]),
  }
  let created_issue = issues.create(create_params)

  // Update an existing issue
  let update_params = {
    title: Some("Updated feature request"),
    body: Some("Updated description with more details"),
    assignee: None,
    state: Some(IssueState::Closed),
    milestone: None,
    labels: Some(["enhancement"]),
    assignees: None,
  }
  let updated_issue = issues.update(42, update_params)

}
```

### Issue Comments

```moonbit
///|
test "issue comments" {
  let client = Octorab::new().with_token("your_token")
  let issues = client.repositories("octocat", "Hello-World").issues()

  // List comments on an issue
  let comments_result = issues.list_comments(42)

  // Create a comment
  let comment_result = issues.create_comment(42, "Thanks for reporting this!")

  // Update a comment
  let updated_comment = issues.update_comment(123456, "Updated comment content")

  // Delete a comment
  let delete_result = issues.delete_comment(123456)

}
```

## Pull Request Operations

### Listing and Getting Pull Requests

```moonbit
///|
test "pull request operations" {
  let client = Octorab::new().with_token("your_token")
  let pulls = client.repositories("octocat", "Hello-World").pulls()

  // List all open pull requests
  let list_params = ListPullRequestsParams::default()
  let pulls_result = pulls.list(list_params)

  // Get a specific pull request
  let pr_result = pulls.get(123)

  // Check if a PR is merged
  let is_merged = pulls.is_merged(123)

}
```

### Creating and Managing Pull Requests

```moonbit
///|
test "create and manage pull requests" {
  let client = Octorab::new().with_token("your_token")
  let pulls = client.repositories("octocat", "Hello-World").pulls()

  // Create a new pull request
  let create_params = {
    title: "Add awesome new feature",
    body: Some("This PR adds an awesome new feature that does X, Y, and Z."),
    head: "feature-branch",
    base: "main",
    draft: Some(false),
    maintainer_can_modify: Some(true),
  }
  let created_pr = pulls.create(create_params)

  // Update a pull request
  let update_params = {
    title: Some("Updated: Add awesome new feature"),
    body: Some("Updated description with more details"),
    state: None,
    base: None,
    maintainer_can_modify: None,
  }
  let updated_pr = pulls.update(123, update_params)

  // Merge a pull request
  let merge_params = {
    commit_title: Some("Merge pull request #123"),
    commit_message: Some("Adds awesome new feature"),
    sha: Some("commit_sha_here"),
    merge_method: Some("merge"),
  }
  let merge_result = pulls.merge(123, merge_params)

}
```

### Pull Request Reviews

```moonbit
///|
test "pull request reviews" {
  let client = Octorab::new().with_token("your_token")
  let pulls = client.repositories("octocat", "Hello-World").pulls()

  // List reviews for a pull request
  let reviews_result = pulls.list_reviews(123)

  // Create a review
  let review_result = pulls.create_review(
    123,
    "APPROVE",
    Some("Looks good to me!"),
  )

  // Submit a pending review
  let submit_result = pulls.submit_review(123, 456, "APPROVE", Some("LGTM!"))

  // Dismiss a review
  let dismiss_result = pulls.dismiss_review(123, 456, "No longer relevant")

}
```

## User Operations

### Getting User Information

```moonbit
///|
test "user information" {
  let client = Octorab::new().with_token("your_token")

  // Get a specific user
  let user_result = client.users("octocat").get()

  // Get the authenticated user
  let current_user_result = client.current_user().get()

  // Update the authenticated user
  let updated_user = client
    .current_user()
    .update(
      Some("John Doe"),
      Some("john@example.com"),
      Some("Software developer passionate about open source"),
    )

}
```

### User Repositories and Activity

```moonbit
///|
test "user repositories and activity" {
  let client = Octorab::new().with_token("your_token")
  let user = client.users("octocat")

  // List user's repositories
  let repos_result = user.list_repos()

  // List user's organizations
  let orgs_result = user.list_orgs()

  // List starred repositories
  let starred_result = user.list_starred()

  // List user's gists
  let gists_result = user.list_gists()

  // List user events
  let events_result = user.list_events()

}
```

### Following Users

```moonbit
///|
test "following users" {
  let client = Octorab::new().with_token("your_token")

  // List followers
  let followers_result = client.users("octocat").list_followers()

  // List following
  let following_result = client.users("octocat").list_following()

  // Check if following a user
  let is_following = client.users("octocat").is_following("defunkt")

  // Follow a user (as authenticated user)
  let follow_result = client.current_user().follow("octocat")

  // Unfollow a user
  let unfollow_result = client.current_user().unfollow("octocat")

}
```

### SSH Keys and Emails

```moonbit
///|
test "ssh keys and emails" {
  let client = Octorab::new().with_token("your_token")
  let current_user = client.current_user()

  // List SSH keys
  let keys_result = current_user.list_ssh_keys()

  // Add an SSH key
  let add_key_result = current_user.add_ssh_key(
    "My Development Key", "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ...",
  )

  // Delete an SSH key
  let delete_key_result = current_user.delete_ssh_key(123456)

  // List email addresses
  let emails_result = current_user.list_emails()

  // Add email addresses
  let add_emails_result = current_user.add_emails([
    "john@example.com", "john.doe@example.org",
  ])

  // Delete email addresses
  let delete_emails_result = current_user.delete_emails(["old@example.com"])

}
```

## Error Handling

The library uses a `Result` type for error handling. All API calls return `Result[T, GitHubError]`:

```moonbit
///|
test "error handling" {
  let client = Octorab::new().with_token("invalid_token")
  match client.repositories("octocat", "Hello-World").get() {
    Ok(repo) =>
      // Handle successful response
      println("Repository: \{repo.name}")
    Err(GitHubError::AuthError(msg)) => println("Authentication error: \{msg}")
    Err(GitHubError::NotFound(msg)) => println("Resource not found: \{msg}")
    Err(GitHubError::RateLimit(msg)) => println("Rate limit exceeded: \{msg}")
    Err(GitHubError::HttpError(status, msg)) =>
      println("HTTP error \{status}: \{msg}")
    Err(error) => println("Other error: \{error}")
  }
}
```

## Configuration

You can customize the client configuration:

```moonbit
///|
test "custom configuration" {
  let config = {
    base_url: "https://api.github.com",
    upload_url: "https://uploads.github.com",
    auth: Auth::PersonalToken("your_token"),
    timeout: 60000, // 60 seconds
    follow_redirects: true,
    max_redirects: 5,
  }
  let client = Octorab::with_config(config)
  // Use the configured client...
}
```

## API Coverage

This library currently covers the following GitHub API endpoints:

### Repositories
- ✅ Get repository information
- ✅ List branches, tags, contributors
- ✅ Get/create/update/delete file contents
- ✅ List commits and get specific commits
- ✅ Fork, star, and unstar repositories
- ✅ List releases and create releases

### Issues
- ✅ List, get, create, and update issues
- ✅ Issue comments (list, create, update, delete)
- ✅ Issue assignees and labels
- ✅ Lock and unlock issues

### Pull Requests
- ✅ List, get, create, and update pull requests
- ✅ Merge pull requests
- ✅ List commits and files in pull requests
- ✅ Pull request reviews and review comments

### Users
- ✅ Get user information (public and authenticated)
- ✅ List repositories, organizations, followers, following
- ✅ User activity (events, starred repos, gists)
- ✅ SSH keys and email management (authenticated user)
- ✅ Follow/unfollow users

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the Apache-2.0 License - see the LICENSE file for details.

## Acknowledgments

- Inspired by the [octocrab](https://github.com/XAMPPRocky/octocrab) Rust library
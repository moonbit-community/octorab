///|
test "percent encode" {
  inspect(percent_encode("a b"), content="a%20b")
  inspect(percent_encode("moon+bit"), content="moon%2Bbit")
}

///|
test "merge query" {
  let params : Map[String, String] = {}
  params["q"] = "hello world"
  params["page"] = "2"
  inspect(build_query(params), content="q=hello%20world&page=2")
}

///|
test "resolve request target" {
  let params : Map[String, String] = {}
  params["q"] = "hello world"
  params["page"] = "2"
  let (origin, path) = resolve_request_target(
    "https://api.github.com", "/api/v3", "/search", params,
  )
  inspect(origin, content="https://api.github.com")
  inspect(path, content="/api/v3/search?q=hello%20world&page=2")
}

///|
test "parse link header" {
  let header = "<https://api.github.com/repositories?since=364>; rel=\"next\", <https://api.github.com/repositories{?since}>; rel=\"first\""
  let links = parse_link_header(header)
  inspect(
    links.next,
    content="Some(\"https://api.github.com/repositories?since=364\")",
  )
  inspect(
    links.first,
    content="Some(\"https://api.github.com/repositories{?since}\")",
  )
}

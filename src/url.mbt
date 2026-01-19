///|
fn parse_base_url(url : String) -> (String, String) raise OctorabError {
  match @url.Url::parse(url) {
    Some(parsed) => {
      let origin = parsed.origin()
      let path = parsed.pathname()
      (origin, normalize_prefix(path))
    }
    None => raise OctorabError::InvalidUrl(url)
  }
}

///|
fn parse_absolute_url(url : String) -> @url.Url raise OctorabError {
  match @url.Url::parse(url) {
    Some(parsed) => parsed
    None => raise OctorabError::InvalidUrl(url)
  }
}

///|
fn normalize_prefix(prefix : String) -> String {
  if prefix == "" || prefix == "/" {
    ""
  } else if prefix.has_suffix("/") {
    let len = prefix.length()
    try! prefix[0:len - 1].to_string()
  } else {
    prefix
  }
}

///|
fn normalize_path(path : String) -> String {
  if path == "" {
    "/"
  } else if path.has_prefix("/") {
    path
  } else {
    "/" + path
  }
}

///|
fn join_path(prefix : String, path : String) -> String {
  let normalized_prefix = normalize_prefix(prefix)
  let normalized_path = normalize_path(path)
  if normalized_prefix == "" {
    normalized_path
  } else {
    normalized_prefix + normalized_path
  }
}

///|
fn is_unreserved(b : Byte) -> Bool {
  let n = b.to_int()
  let is_digit = n >= 48 && n <= 57
  let is_upper = n >= 65 && n <= 90
  let is_lower = n >= 97 && n <= 122
  let is_mark = b is (b'-' | b'.' | b'_' | b'~')
  is_digit || is_upper || is_lower || is_mark
}

///|
fn percent_encode(input : String) -> String {
  let bytes = @utf8.encode(input)
  let out : Array[Byte] = []
  let hex : Bytes = b"0123456789ABCDEF"
  for b in bytes {
    if is_unreserved(b) {
      out.push(b)
    } else {
      let n = b.to_int()
      out.push(b'%')
      out.push(hex[(n >> 4) & 0x0f])
      out.push(hex[n & 0x0f])
    }
  }
  @utf8.decode_lossy(Bytes::from_array(out)[:])
}

///|
fn build_query(params : Map[String, String]) -> String {
  if params.length() == 0 {
    return ""
  }
  let parts : Array[String] = []
  for key, value in params {
    let encoded_key = percent_encode(key)
    let encoded_value = percent_encode(value)
    parts.push("\{encoded_key}=\{encoded_value}")
  }
  parts.join("&")
}

///|
fn header_value(headers : Map[String, String], name : String) -> String? {
  let target = name.to_lower()
  for key, value in headers {
    if key.to_lower() == target {
      return Some(value)
    }
  }
  None
}

///|
fn add_query(
  params : Map[String, String],
  key : String,
  value : String?,
) -> Unit {
  if value is Some(v) {
    params[key] = v
  }
}

///|
fn add_query_int(
  params : Map[String, String],
  key : String,
  value : Int?,
) -> Unit {
  if value is Some(v) {
    params[key] = v.to_string()
  }
}

///|
fn add_query_bool(
  params : Map[String, String],
  key : String,
  value : Bool?,
) -> Unit {
  if value is Some(v) {
    params[key] = if v { "true" } else { "false" }
  }
}

///|
fn merge_query_string(lhs : String, rhs : String) -> String {
  if lhs == "" {
    rhs
  } else if rhs == "" {
    lhs
  } else {
    "\{lhs}&\{rhs}"
  }
}

///|
fn apply_query_params(url : @url.Url, params : Map[String, String]) -> Unit {
  if params.length() == 0 {
    return
  }
  let existing = url.search()
  let base = if existing == "" { "" } else { try! existing[1:].to_string() }
  let extra = build_query(params)
  let merged = merge_query_string(base, extra)
  if merged != "" {
    url.set_search(merged)
  }
}

///|
fn split_path_query(path : String) -> (String, String?) {
  if path.find("?") is Some(i) {
    let base = try! path[:i].to_string()
    let query = try! path[i + 1:].to_string()
    (base, Some(query))
  } else {
    (path, None)
  }
}

///|
fn resolve_request_target(
  base_origin : String,
  base_path : String,
  url_or_path : String,
  params : Map[String, String],
) -> (String, String) raise OctorabError {
  match @url.Url::parse(url_or_path) {
    Some(parsed) => {
      apply_query_params(parsed, params)
      let path = "\{parsed.pathname()}\{parsed.search()}"
      (parsed.origin(), path)
    }
    None => {
      let (raw_path, query) = split_path_query(url_or_path)
      let full_path = join_path(base_path, raw_path)
      let base = parse_absolute_url(base_origin)
      base.set_pathname(full_path)
      if query is Some(q) {
        base.set_search(q)
      }
      apply_query_params(base, params)
      let path = "\{base.pathname()}\{base.search()}"
      (base.origin(), path)
    }
  }
}

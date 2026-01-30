///|
let default_base_url : String = "https://api.github.com"

///|
let default_api_version : String = "2022-11-28"

///|
let default_user_agent : String = "octorab/0.1.0 (MoonBit)"

///|
pub struct Octorab {
  base_uri : String
  base_path : String
  user_agent : String
  auth : Auth?
  api_version : String
  extra_headers : Map[String, String]
}

///|
pub fn Octorab::default() -> Octorab {
  try! Octorab::new()
}

///|
pub fn Octorab::new(
  base_url? : String = default_base_url,
  user_agent? : String = default_user_agent,
  api_version? : String = default_api_version,
  auth? : Auth,
) -> Octorab raise OctorabError {
  let (base_uri, base_path) = parse_base_url(base_url)
  {
    base_uri,
    base_path: normalize_prefix(base_path),
    user_agent,
    auth,
    api_version,
    extra_headers: {},
  }
}

///|
pub fn Octorab::with_auth(self : Octorab, auth : Auth) -> Octorab {
  { ..self, auth: Some(auth) }
}

///|
pub fn Octorab::with_token(self : Octorab, token : String) -> Octorab {
  self.with_auth(Auth::token(token))
}

///|
pub fn Octorab::with_bearer(self : Octorab, token : String) -> Octorab {
  self.with_auth(Auth::bearer(token))
}

///|
pub fn Octorab::with_user_agent(self : Octorab, user_agent : String) -> Octorab {
  { ..self, user_agent, }
}

///|
pub fn Octorab::with_api_version(
  self : Octorab,
  api_version : String,
) -> Octorab {
  { ..self, api_version, }
}

///|
pub fn Octorab::with_base_url(
  self : Octorab,
  base_url : String,
) -> Octorab raise OctorabError {
  let (base_uri, base_path) = parse_base_url(base_url)
  { ..self, base_uri, base_path: normalize_prefix(base_path) }
}

///|
pub fn Octorab::with_header(
  self : Octorab,
  name : String,
  value : String,
) -> Octorab {
  let headers : Map[String, String] = {}
  for key, val in self.extra_headers {
    headers[key] = val
  }
  headers[name] = value
  { ..self, extra_headers: headers }
}

///|
fn Octorab::base_headers(self : Octorab) -> Map[String, String] {
  let headers : Map[String, String] = {}
  headers["User-Agent"] = self.user_agent
  headers["Accept"] = "application/vnd.github+json"
  headers["X-GitHub-Api-Version"] = self.api_version
  if self.auth is Some(auth) {
    let (key, value) = auth.header()
    headers[key] = value
  }
  for key, value in self.extra_headers {
    headers[key] = value
  }
  headers
}

///|
fn merge_headers(
  base : Map[String, String],
  extra : Map[String, String],
) -> Map[String, String] {
  let merged : Map[String, String] = {}
  for key, value in base {
    merged[key] = value
  }
  for key, value in extra {
    merged[key] = value
  }
  merged
}

///|
fn Octorab::resolve_target(
  self : Octorab,
  url_or_path : String,
  params : Map[String, String],
) -> (String, String) raise OctorabError {
  resolve_request_target(self.base_uri, self.base_path, url_or_path, params)
}

///|
pub async fn Octorab::request_raw(
  self : Octorab,
  http_method : @http.RequestMethod,
  url_or_path : String,
  query? : Map[String, String] = {},
  body? : &@io.Data,
  headers? : Map[String, String] = {},
) -> (@http.Response, &@io.Data) {
  let (base_uri, path) = self.resolve_target(url_or_path, query)
  let merged_headers = merge_headers(self.base_headers(), headers)
  let client = @http.Client::new(base_uri, headers=merged_headers)
  defer client.close()
  client.request(http_method, path)
  if body is Some(data) {
    client.write(data)
  }
  let response = client.end_request()
  let data = client.read_all()
  (response, data)
}

///|
pub async fn Octorab::request(
  self : Octorab,
  http_method : @http.RequestMethod,
  url_or_path : String,
  query? : Map[String, String] = {},
  body? : &@io.Data,
  headers? : Map[String, String] = {},
) -> (@http.Response, &@io.Data) {
  let (response, data) = match body {
    Some(data) =>
      self.request_raw(http_method, url_or_path, query~, body=data, headers~)
    None => self.request_raw(http_method, url_or_path, query~, headers~)
  }
  if is_success_status(response.code) {
    return (response, data)
  }
  let error = parse_github_error(response.code, data)
  raise OctorabError::HttpError(error)
}

///|
fn with_json_header(headers : Map[String, String]) -> Map[String, String] {
  if header_value(headers, "content-type") is Some(_) {
    headers
  } else {
    let updated : Map[String, String] = {}
    for key, value in headers {
      updated[key] = value
    }
    updated["Content-Type"] = "application/json"
    updated
  }
}

///|
pub async fn[T : FromJson] Octorab::request_json(
  self : Octorab,
  http_method : @http.RequestMethod,
  url_or_path : String,
  query? : Map[String, String] = {},
  body? : Json,
  headers? : Map[String, String] = {},
) -> T {
  let json_headers = if body is Some(_) {
    with_json_header(headers)
  } else {
    headers
  }
  let (_response, data) = match body {
    Some(json) =>
      self.request(
        http_method,
        url_or_path,
        query~,
        body=json,
        headers=json_headers,
      )
    None => self.request(http_method, url_or_path, query~, headers=json_headers)
  }
  let parsed = data.json()
  @json.from_json(parsed)
}

///|
pub async fn Octorab::get_raw(
  self : Octorab,
  url_or_path : String,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> (@http.Response, &@io.Data) {
  self.request_raw(@http.RequestMethod::Get, url_or_path, query~, headers~)
}

///|
pub async fn[T : FromJson] Octorab::get(
  self : Octorab,
  url_or_path : String,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> T {
  self.request_json(@http.RequestMethod::Get, url_or_path, query~, headers~)
}

///|
pub async fn Octorab::post_raw(
  self : Octorab,
  url_or_path : String,
  body : &@io.Data,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> (@http.Response, &@io.Data) {
  self.request_raw(
    @http.RequestMethod::Post,
    url_or_path,
    query~,
    body~,
    headers~,
  )
}

///|
pub async fn[T : FromJson] Octorab::post(
  self : Octorab,
  url_or_path : String,
  body : Json,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> T {
  self.request_json(
    @http.RequestMethod::Post,
    url_or_path,
    query~,
    body~,
    headers~,
  )
}

///|
pub async fn[T : FromJson] Octorab::patch(
  self : Octorab,
  url_or_path : String,
  body : Json,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> T {
  self.request_json(
    @http.RequestMethod::Patch,
    url_or_path,
    query~,
    body~,
    headers~,
  )
}

///|
pub async fn[T : FromJson] Octorab::put(
  self : Octorab,
  url_or_path : String,
  body : Json,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> T {
  self.request_json(
    @http.RequestMethod::Put,
    url_or_path,
    query~,
    body~,
    headers~,
  )
}

///|
pub async fn Octorab::delete(
  self : Octorab,
  url_or_path : String,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> Unit {
  let _ = self.request(
    @http.RequestMethod::Delete,
    url_or_path,
    query~,
    headers~,
  )
  ()
}

///|
pub async fn[T : FromJson] Octorab::get_page(
  self : Octorab,
  url_or_path : String,
  query? : Map[String, String] = {},
  headers? : Map[String, String] = {},
) -> Page[T] {
  let (response, data) = self.request(
    @http.RequestMethod::Get,
    url_or_path,
    query~,
    headers~,
  )
  if response.code == 204 {
    return Page::empty()
  }
  let bytes = data.binary()
  if bytes.length() == 0 {
    return Page::empty()
  }
  let json = bytes |> @utf8.decode |> @json.parse
  parse_page(json, response.headers)
}

///|
pub async fn[T : FromJson] Octorab::get_page_opt(
  self : Octorab,
  url : String?,
) -> Page[T]? {
  match url {
    Some(next_url) => Some(self.get_page(next_url))
    None => None
  }
}

///|
pub async fn[T : FromJson] Octorab::all_pages(
  self : Octorab,
  page : Page[T],
) -> Array[T] {
  let items : Array[T] = []
  for item in page.items {
    items.push(item)
  }
  let mut next = page.next
  while next is Some(url) {
    let next_page = self.get_page(url)
    for item in next_page.items {
      items.push(item)
    }
    next = next_page.next
  }
  items
}

///|
let global_instance : Ref[Octorab?] = Ref::new(None)

///|
pub fn initialise(client : Octorab) -> Unit {
  global_instance.val = Some(client)
}

///|
pub fn instance() -> Octorab {
  match global_instance.val {
    Some(client) => client
    None => {
      let client = Octorab::default()
      global_instance.val = Some(client)
      client
    }
  }
}

///|
pub struct PageLinks {
  mut next : String?
  mut prev : String?
  mut first : String?
  mut last : String?
} derive(Show, ToJson, Eq)

///|
pub fn PageLinks::empty() -> PageLinks {
  { next: None, prev: None, first: None, last: None }
}

///|
pub struct Page[T] {
  items : Array[T]
  next : String?
  prev : String?
  first : String?
  last : String?
  total_count : Int?
  incomplete_results : Bool?
}

///|
pub fn[T] Page::empty() -> Page[T] {
  {
    items: [],
    next: None,
    prev: None,
    first: None,
    last: None,
    total_count: None,
    incomplete_results: None,
  }
}

///|
pub fn[T] Page::take_items(self : Page[T]) -> Array[T] {
  self.items
}

///|
struct SearchPage[T] {
  total_count : Int?
  incomplete_results : Bool?
  items : Array[T]
} derive(FromJson)

///|
fn parse_link_header(value : String) -> PageLinks {
  let links = PageLinks::empty()
  for raw_part in value.split(",") {
    let part = raw_part.trim().to_string()
    guard part.has_prefix("<") else { continue }
    guard part.find(">") is Some(end_index) else { continue }
    let url = try! part[1:end_index].to_string()
    let rel = find_rel(part)
    match rel {
      Some("next") => links.next = Some(url)
      Some("prev") => links.prev = Some(url)
      Some("first") => links.first = Some(url)
      Some("last") => links.last = Some(url)
      _ => ()
    }
  }
  links
}

///|
fn find_rel(part : String) -> String? {
  let key = "rel=\""
  guard part.find(key) is Some(start) else { return None }
  let from = start + key.length()
  let rest = try! part[from:].to_string()
  guard rest.find("\"") is Some(end_index) else { return None }
  Some(try! part[from:from + end_index].to_string())
}

///|
fn parse_links(headers : Map[String, String]) -> PageLinks {
  match header_value(headers, "link") {
    Some(value) => parse_link_header(value)
    None => PageLinks::empty()
  }
}

///|
fn[T : FromJson] parse_page(
  body : Json,
  headers : Map[String, String],
) -> Page[T] raise {
  let links = parse_links(headers)
  match body {
    Json::Array(_) => {
      let items : Array[T] = @json.from_json(body)
      {
        items,
        next: links.next,
        prev: links.prev,
        first: links.first,
        last: links.last,
        total_count: None,
        incomplete_results: None,
      }
    }
    Json::Object(map) =>
      if map is { "items": _, .. } {
        let search : SearchPage[T] = @json.from_json(body)
        {
          items: search.items,
          next: links.next,
          prev: links.prev,
          first: links.first,
          last: links.last,
          total_count: search.total_count,
          incomplete_results: search.incomplete_results,
        }
      } else {
        // fallback: treat the object as a single item page
        let item : T = @json.from_json(body)
        {
          items: [item],
          next: links.next,
          prev: links.prev,
          first: links.first,
          last: links.last,
          total_count: None,
          incomplete_results: None,
        }
      }
    _ => {
      let items : Array[T] = @json.from_json(body)
      {
        items,
        next: links.next,
        prev: links.prev,
        first: links.first,
        last: links.last,
        total_count: None,
        incomplete_results: None,
      }
    }
  }
}

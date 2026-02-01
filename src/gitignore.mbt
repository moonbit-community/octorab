///|
pub struct GitignoreHandler {
  crab : Octorab
}

///|
pub fn Octorab::gitignore(self : Octorab) -> GitignoreHandler {
  { crab: self }
}

///|
pub async fn GitignoreHandler::list_templates(
  self : GitignoreHandler,
) -> Array[String] {
  self.crab.get("/gitignore/templates")
}

///|
pub async fn GitignoreHandler::get_template(
  self : GitignoreHandler,
  name : String,
) -> Json {
  self.crab.get("/gitignore/templates/\{name}")
}

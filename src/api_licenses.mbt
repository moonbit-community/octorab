///|
pub struct LicensesHandler {
  crab : Octorab
}

///|
pub fn Octorab::licenses(self : Octorab) -> LicensesHandler {
  { crab: self }
}

///|
pub async fn LicensesHandler::list(self : LicensesHandler) -> Array[Json] {
  self.crab.get("/licenses")
}

///|
pub async fn LicensesHandler::get(self : LicensesHandler, key : String) -> Json {
  self.crab.get("/licenses/\{key}")
}

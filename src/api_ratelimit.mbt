///|
pub async fn Octorab::rate_limit(self : Octorab) -> Json {
  self.get("/rate_limit")
}

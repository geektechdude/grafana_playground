resource "grafana_data_source" "github" {
  type = "grafana-github-datasource"
  name = "github-geektechstuff"

  secure_json_data_encoded = jsonencode({
    "selectedAuthType" = "personal-access-token"
    "accessToken"      = var.github_token
  })
}

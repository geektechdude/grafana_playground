resource "grafana_folder" "geektechstuff" {
  title = "geektechstuff folder"
}

resource "grafana_dashboard" "geektechstuff_github" {
  folder = grafana_folder.geektechstuff.id
  config_json = file("../grafana_dashboards/github_stats.json")
  overwrite = true
}    

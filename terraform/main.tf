resource "grafana_folder" "geektechstuff" {
  title = "geektechstuff folder"
}

resource "grafana_dashboard" "geektechstuff_github" {
  folder      = grafana_folder.geektechstuff.id
  for_each = fileset("../grafana_dashboards/", "*.json")  
  config_json = jsonencode(merge(jsondecode(file("../grafana_dashboards/${each.key}")),
	{tags = ["TERRAFORM-MANAGED"]} ))
  overwrite   = true
}

resource "grafana_service_account" "python_sa" {
  name = "python-service-account"
  role = "Viewer"
}

resource "grafana_service_account_rotating_token" "python_token" {
  name_prefix = "python_token"
  service_account_id = grafana_service_account.python_sa.id
  seconds_to_live = 604800 
  early_rotation_window_seconds = 302400
}


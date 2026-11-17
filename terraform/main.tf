resource "grafana_folder" "geektechstuff" {
  title = "geektechstuff folder"
}

resource "grafana_dashboard" "dashboardsv1" {
  folder      = grafana_folder.geektechstuff.id
  for_each = fileset("../grafana_dashboards/", "*-v1.json")  
  config_json = jsonencode(merge(jsondecode(file("../grafana_dashboards/${each.key}")),
	{tags = ["TERRAFORM-MANAGED", "V1"]} ))
  overwrite   = true
}

resource "grafana_apps_dashboard_dashboard_v2" "dashboardsv2" {
  for_each = fileset("../grafana_dashboards/", "*-v2.json")

  metadata {
    # Dynamically extract a unique identifier from the filename
    uid = replace(lower(each.key), ".json", "")
  }

  spec {
    # 1. Provide the tags natively outside of the JSON payload
    tags = ["TERRAFORM-MANAGED", "V2"]

    # 2. Extract and provide just the spec block from your JSON v2 files
    json = jsonencode(jsondecode(file("../grafana_dashboards/${each.key}")).spec)
  }

  options {
    overwrite = true
  }
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


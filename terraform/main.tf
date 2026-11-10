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

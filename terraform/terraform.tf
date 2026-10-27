terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "4.46.0"
      }
    }
}

provider "grafana" {
  url = "http://GRAFANA_IP:GRAFANA_PORT"
  auth = ""
}

resource "grafana_folder" "geektechstuff" {
  title = "geektechstuff folder"
}    

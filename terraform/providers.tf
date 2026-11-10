terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "4.54.0"
    }
  }
}

provider "grafana" {
  url  = var.grafana_address
  auth = var.grafana_token
}

variable "grafana_address" {
  description = "IPADDRESS:PORT of Grafana"
  type = string
  default = "http://localhost:3000"
}

variable "grafana_token" {
  description = "Access token for Grafana"
  type = string
}

variable "github_token" {
  description = "Auth token for GitHub"
  type = string
}

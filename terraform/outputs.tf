output "service_account_python_sa_token_key" {
  value = grafana_service_account_rotating_token.python_token.key
  sensitive = true
}

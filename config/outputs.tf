output "openbao_idp_client_id" {
  description = "Openbao Client ID"
  value       = module.identity_provider.app_client_id
  sensitive   = true
}

output "openbao_idp_client_secret" {
  description = "Openbao Client Secret"
  value       = module.identity_provider.app_client_secret
  sensitive   = true
}

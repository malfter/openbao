output "app_client_id" {
  description = "Application Client ID"
  value       = keycloak_openid_client.openid_client.client_id
  sensitive   = true
}

output "app_client_secret" {
  description = "Application Client Secret"
  value       = keycloak_openid_client.openid_client.client_secret
  sensitive   = true
}

output "oidc_discovery_url" {
  description = "OIDC Discovery URL"
  value       = join("/", [var.keycloak_url, "realms", var.realm_name])
}

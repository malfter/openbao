locals {
  openbao_oidc_callback = "${var.openbao_addr}/ui/vault/auth/oidc/oidc/callback"
}

module "identity_provider" {
  source = "./roles/identity-provider-keycloak"

  keycloak_url  = var.keycloak_url
  realm_name    = var.keycloak_realm_name
  app_client_id = var.keycloak_app_client_id
  users         = var.keycloak_users

  valid_redirect_uris = [
    local.openbao_oidc_callback
  ]
}

module "openbao_oidc" {
  source = "./roles/openbao-oidc"

  oidc_client_id     = module.identity_provider.app_client_id
  oidc_client_secret = module.identity_provider.app_client_secret
  oidc_discovery_url = module.identity_provider.oidc_discovery_url

  oidc_allowed_redirect_uris = [
    local.openbao_oidc_callback
  ]
}

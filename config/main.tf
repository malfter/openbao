resource "vault_mount" "example" {
  path        = "dummy"
  type        = "generic"
  description = "This is an example mount"
}

module "identity_provider" {
  source = "./roles/identity-provider-keycloak"

  openbao_valid_redirect_uris = [
    "https://keycloak-127.0.0.1.nip.io:8443/openid-callback"
  ]
}

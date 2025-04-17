resource "vault_policy" "reader" {
  name = "reader"

  policy = <<EOT
path "/secret/*" {
    capabilities = ["read", "list"]
}
EOT
}

resource "vault_jwt_auth_backend" "oidc" {
  description        = "Demonstration of the Terraform JWT auth backend"
  path               = "oidc"
  type               = "oidc"
  oidc_discovery_url = var.oidc_discovery_url
  oidc_client_id     = var.oidc_client_id
  oidc_client_secret = var.oidc_client_secret
  default_role       = "reader"
}

resource "vault_jwt_auth_backend_role" "reader" {
  role_name             = "reader"
  backend               = vault_jwt_auth_backend.oidc.path
  bound_audiences       = [var.oidc_client_id]
  allowed_redirect_uris = var.oidc_allowed_redirect_uris
  user_claim            = "sub"
  token_policies        = [vault_policy.reader.name]
}

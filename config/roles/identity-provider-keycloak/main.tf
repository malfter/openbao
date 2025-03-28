# https://openbao.org/docs/auth/jwt/oidc-providers/keycloak/

resource "keycloak_realm" "this" {
  realm   = var.realm_name
  enabled = true
}

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.this.id
  client_id           = var.openbao_client_id

  name                = var.openbao_client_id
  enabled             = true

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = var.openbao_valid_redirect_uris
  standard_flow_enabled = true
}

provider "vault" {
  # Configuration options
  address         = var.openbao_addr
  token           = var.openbao_token
  skip_tls_verify = var.openbao_skip_tls_verify
}

provider "keycloak" {
  # Configuration options
  client_id = var.keycloak_client_id
  username  = var.keycloak_username
  password  = var.keycloak_password
  url       = var.keycloak_url
}

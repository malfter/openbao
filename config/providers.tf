provider "vault" {
  # Configuration options
  address = var.vault_addr
  token   = var.vault_token
}

provider "keycloak" {
  # Configuration options
  client_id = var.keycloak_client_id
  username  = var.keycloak_username
  password  = var.keycloak_password
  url       = var.keycloak_url
}

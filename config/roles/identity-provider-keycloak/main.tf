resource "keycloak_realm" "this" {
  realm   = var.realm_name
  enabled = true
}

resource "keycloak_openid_client" "openid_client" {
  realm_id  = keycloak_realm.this.id
  client_id = var.app_client_id

  name    = var.app_client_id
  enabled = true

  access_type           = "CONFIDENTIAL"
  valid_redirect_uris   = var.valid_redirect_uris
  standard_flow_enabled = true
}

resource "keycloak_user" "user" {
  count = length(var.users)

  realm_id = keycloak_realm.this.id
  username = var.users[count.index].username
  enabled  = var.users[count.index].enable

  first_name = var.users[count.index].first_name
  last_name  = var.users[count.index].last_name
  email      = var.users[count.index].email

  initial_password {
    value     = var.users[count.index].initial_password.value
    temporary = var.users[count.index].initial_password.temporary
  }
}

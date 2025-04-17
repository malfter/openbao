# TODO Use client credential grant
# https://search.opentofu.org/provider/keycloak/keycloak/latest#example-usage-client-credentials-grant
keycloak_client_id = "admin-cli"
keycloak_username  = "admin"
keycloak_password  = "admin"
keycloak_url       = "http://keycloak-172.20.0.1.nip.io:7080"

keycloak_realm_name    = "openbao"
keycloak_app_client_id = "openbao"
keycloak_users = [
  {
    username   = "foo"
    enable     = true
    first_name = "Foo"
    last_name  = "Bar"
    email      = "foo.bar@example.org"
    initial_password = {
      value     = "bar" # Plain text password is only used here in the demo.
      temporary = false
    }
  }
]

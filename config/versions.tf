terraform {
  required_version = ">= 1.8.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.1.1"
    }
  }
}

variable "opentofu_state_passphrase" {
  description = "State encryption passphrase"
  type        = string
  sensitive   = true
  validation {
    condition     = (length(var.opentofu_state_passphrase) >= 16)
    error_message = "The opentofu_state_passphrase value must be at least 16 characters long."
  }
}

variable "vault_addr" {
  description = "Vault Address"
  type        = string
}

variable "vault_token" {
  description = "Vault Token"
  type        = string
  sensitive   = true
}

variable "keycloak_client_id" {
  description = "OpenTofu Provider Keycloak Client ID"
  type        = string
}

variable "keycloak_username" {
  description = "OpenTofu Provider Keycloak Username"
  type        = string
}

variable "keycloak_password" {
  description = "OpenTofu Provider Keycloak Password"
  type        = string
}

variable "keycloak_url" {
  description = "OpenTofu Provider Keycloak URL"
  type        = string
}

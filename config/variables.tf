variable "opentofu_state_passphrase" {
  description = "State encryption passphrase"
  type        = string
  sensitive   = true
  validation {
    condition     = (length(var.opentofu_state_passphrase) >= 16)
    error_message = "The opentofu_state_passphrase value must be at least 16 characters long."
  }
}

variable "openbao_addr" {
  description = "Vault Address"
  type        = string
}

variable "openbao_token" {
  description = "Vault Token"
  type        = string
  sensitive   = true
}

variable "openbao_skip_tls_verify" {
  description = "Vault Skip TLS Verify"
  type        = bool
  default     = false
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

variable "keycloak_users" {
  description = "List of users to create in Keycloak"
  type = list(object({
    enable     = bool
    username   = string
    email      = string
    first_name = string
    last_name  = string
    initial_password = object({
      value     = string
      temporary = bool
    })
  }))
  default   = []
  sensitive = true
}

variable "keycloak_realm_name" {
  description = "Keycloak Realm Name"
  type        = string
}

variable "keycloak_app_client_id" {
  description = "Application Client ID"
  type        = string
}

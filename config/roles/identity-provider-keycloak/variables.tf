variable "keycloak_url" {
  description = "Keycloak URL"
  type        = string
  default     = "http://localhost:8080"
}

variable "realm_name" {
  description = "Realm Name"
  type        = string
  default     = "test"
}

variable "app_client_id" {
  description = "Application Client ID"
  type        = string
  default     = "test"
}

variable "valid_redirect_uris" {
  description = "Valid redirect URIs"
  type        = list(string)
  default = [
    "http://localhost:8080/openid-callback"
  ]
}

variable "users" {
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

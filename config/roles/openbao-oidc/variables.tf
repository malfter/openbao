variable "oidc_client_id" {
  description = "OIDC Client ID"
  type        = string
}

variable "oidc_client_secret" {
  description = "OIDC Client Secret"
  type        = string
  sensitive   = true
}

variable "oidc_discovery_url" {
  description = "OIDC Discovery URL"
  type        = string
}

variable "oidc_allowed_redirect_uris" {
  description = "OIDC Allowed Redirect URIs"
  type        = list(string)
}

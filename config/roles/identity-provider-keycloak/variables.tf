variable realm_name {
  description = "Realm Name"
  type        = string
  default     = "openbao"
}

variable "openbao_client_id" {
  description = "OpenBao Client ID"
  type        = string
  default     = "openbao"
}

variable "openbao_valid_redirect_uris" {
  description = "OpenBao valid redirect URIs"
  type        = list(string)
  default     = [
    "http://localhost:8080/openid-callback"
  ]
}



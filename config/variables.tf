variable "opentofu_state_passphrase" {
  description = "State encryption passphrase"
  type        = string
  sensitive   = true
  validation {
    condition = (length(var.opentofu_state_passphrase) >= 16)
      error_message = "The opentofu_state_passphrase value must be at least 16 characters long."
  }
}

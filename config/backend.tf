terraform {
  # backend "http" {
  # }
  encryption {
    key_provider "pbkdf2" "mykey" {
      passphrase = var.opentofu_state_passphrase
    }

    method "aes_gcm" "new_method" {
      keys = key_provider.pbkdf2.mykey
    }

    state {
      # Encryption/decryption for state data
      method   = method.aes_gcm.new_method
      enforced = true
    }

    plan {
      # Encryption/decryption for plan data
      method   = method.aes_gcm.new_method
      enforced = true
    }
  }
}


variable "enable_vault_integration" {
  description = "When true, publish Terraform backend metadata to Vault."
  type        = bool
  default     = false
}

variable "vault_kv_mount" {
  description = "Vault KV v2 mount used to store the Terraform backend metadata."
  type        = string
  default     = "secret"
}

variable "vault_secret_path" {
  description = "Path inside the Vault KV mount where Terraform backend metadata will be written."
  type        = string
  default     = "terraform/eks-backend"
}

variable "key_vaults" {
  type = map(object({
    kv_name  = string
    location = string
    rg_name  = string
  }))
}

variable "vm_username" {
  description = "Username for VM admin"
  type        = string
  default     = "azureuser"
}

variable "vm_password" {
  description = "Password for VM admin"
  type        = string
  default     = "P@ssw0rd123!"
}

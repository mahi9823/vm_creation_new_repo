variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "networks" {
  type = map(any)
}
variable "public_ips" {
  type = map(any)
}
variable "key_vaults" {
  type = map(any)
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

variable "vms" {
  type = map(object({
    nic_name    = string
    location    = string
    rg_name     = string
    vnet_name   = string
    subnet_name = string
    pip_name    = string
    vm_name     = string
    size        = string
    kv_name     = optional(string)
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

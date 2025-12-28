module "resource_group" {
  source = "../module/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  depends_on = [module.resource_group]
  source     = "../module/azurerm_networking"
  networks   = var.networks
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../module/azurerm_public_ip"
  public_ips = var.public_ips
}

module "key_vault" {
  depends_on  = [module.resource_group]
  source      = "../module/azurerm_key_vault"
  key_vaults  = var.key_vaults
  vm_username = var.vm_username
  vm_password = var.vm_password
}

resource "azurerm_storage_account" "audit_storage" {
  name                     = "auditstoragedevtodoapp"
  resource_group_name      = var.rgs["rg1"].name
  location                 = var.rgs["rg1"].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

module "sql_server" {
  depends_on      = [module.resource_group, azurerm_storage_account.audit_storage]
  source          = "../module/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp"
  rg_name         = var.rgs["rg1"].name
  location        = var.rgs["rg1"].location
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = {}
  audit_storage_endpoint = azurerm_storage_account.audit_storage.primary_blob_endpoint
  audit_storage_account_access_key = azurerm_storage_account.audit_storage.primary_access_key
  audit_retention_in_days = 90
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../module/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = {}
}

module "compute" {
  depends_on = [module.network, module.public_ip, module.key_vault]
  source     = "../module/azurerm_compute"
  vms        = var.vms
}

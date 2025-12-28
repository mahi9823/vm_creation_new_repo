resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit_policy" {
  server_id                               = azurerm_mssql_server.sql_server.id
  storage_endpoint                        = var.audit_storage_endpoint
  storage_account_access_key              = var.audit_storage_account_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.audit_retention_in_days
}

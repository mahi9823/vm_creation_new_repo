# TODO: Fix tfsec Issues

- [x] Add storage account in dev/main.tf for audit logs
- [x] Update module/azurerm_sql_server/variable.tf to include auditing variables
- [x] Update module/azurerm_sql_server/main.tf to disable public access and add auditing policy
- [x] Update dev/main.tf to pass new variables to sql_server module and add depends_on

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.law.name
}
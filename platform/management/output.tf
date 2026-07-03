output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "log_analytics_workspace_id" {
  value = module.management.resource_id
}

output "log_analytics_workspace_name" {
  value = "law-${var.prefix}-mgmt"
}

output "automation_account_id" {
  value = module.management.automation_account.id
}

output "data_collection_rule_ids" {
  value = module.management.data_collection_rule_ids
}
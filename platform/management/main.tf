resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-mgmt"
  location = var.location
  tags     = var.tags
}

module "management" {
  source  = "Azure/avm-ptn-alz-management/azurerm"
  version = "~> 0.9"

  resource_group_creation_enabled = false
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location

  log_analytics_workspace_name              = "law-${var.prefix}-mgmt"
  log_analytics_workspace_sku               = var.log_analytics_sku
  log_analytics_workspace_retention_in_days = var.log_retention_in_days
  log_analytics_workspace_daily_quota_gb    = 1

  linked_automation_account_creation_enabled = true
  automation_account_name                    = "aa-${var.prefix}-mgmt"

  sentinel_onboarding = var.enable_sentinel ? {} : null
  tags                = var.tags
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-mgmt"
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.prefix}-mgmt"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_in_days
  daily_quota_gb      = 1
}

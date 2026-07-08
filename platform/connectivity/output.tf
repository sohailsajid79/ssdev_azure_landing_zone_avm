output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "hub_vnet_id" {
  value = module.hub_and_spoke.resource_id["primary"]
}

output "hub_vnet_name" {
  value = "vnet-${var.prefix}-hub"
}
output "corp_vnet_id" {
  value = module.vnet.resource_id
}

output "corp_vnet_name" {
  value = module.vnet.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}
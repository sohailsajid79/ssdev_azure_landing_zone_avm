resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-corp"
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.prefix}-corp-workload"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
  # default NSG rules allow intra-VNet + peered-VNet
  # traffic and deny inbound internet.
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "= 0.19.0"

  name          = "vnet-${var.prefix}-corp"
  location      = var.location
  parent_id     = azurerm_resource_group.rg.id
  address_space = var.corp_address_space

  subnets = {
    workload = {
      name             = "snet-workload"
      address_prefixes = ["10.20.1.0/24"]
      network_security_group = {
        id = azurerm_network_security_group.nsg.id
      }
    }
  }

  # One block, both directions: corp -> hub and (reverse) hub -> corp.
  # The reverse leg is created in the connectivity subscription
  peerings = {
    to_hub = {
      name                               = "peer-corp-to-hub"
      remote_virtual_network_resource_id = var.hub_vnet_id
      allow_forwarded_traffic            = true
      allow_virtual_network_access       = true

      create_reverse_peering               = true
      reverse_name                         = "peer-hub-to-corp"
      reverse_allow_forwarded_traffic      = true
      reverse_allow_virtual_network_access = true
    }
  }

  tags = var.tags
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-online"
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-${var.prefix}-online-workload"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# App Gateway v2 subnets have mandatory NSG rules: without the
# GatewayManager allowance the gateway deployment fails.
resource "azurerm_network_security_group" "appgw" {
  name                = "nsg-${var.prefix}-online-appgw"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  security_rule {
    name                       = "AllowGatewayManager"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancer"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "= 0.19.0"

  name          = "vnet-${var.prefix}-online"
  location      = var.location
  parent_id     = azurerm_resource_group.rg.id
  address_space = var.online_address_space

  subnets = {
    workload = {
      name             = "snet-workload"
      address_prefixes = ["10.30.1.0/24"]
      network_security_group = {
        id = azurerm_network_security_group.workload.id
      }
    }
    appgw = {
      name             = "snet-appgw"
      address_prefixes = ["10.30.2.0/24"]
      network_security_group = {
        id = azurerm_network_security_group.appgw.id
      }
    }
  }

  peerings = {
    to_hub = {
      name                               = "peer-online-to-hub"
      remote_virtual_network_resource_id = var.hub_vnet_id
      allow_forwarded_traffic            = true
      allow_virtual_network_access       = true

      create_reverse_peering               = true
      reverse_name                         = "peer-hub-to-online"
      reverse_allow_forwarded_traffic      = true
      reverse_allow_virtual_network_access = true
    }
  }

  tags = var.tags
}
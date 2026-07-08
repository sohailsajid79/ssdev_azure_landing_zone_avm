resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-connectivity"
  location = var.location
  tags     = var.tags
}

module "hub_and_spoke" {
  source  = "Azure/avm-ptn-alz-connectivity-hub-and-spoke-vnet/azurerm"
  version = "~> 0.17"

  hub_and_spoke_networks_settings = {
    enabled_resources = {
      ddos_protection_plan = false
    }
  }

  hub_virtual_networks = {
    primary = {
      location = var.location

      enabled_resources = {
        firewall                              = false
        firewall_policy                       = false
        bastion                               = false
        virtual_network_gateway_express_route = false
        virtual_network_gateway_vpn           = false
        private_dns_zones                     = true
        private_dns_resolver                  = false
        dns_resolver_policy                   = false
        nat_gateway                           = false
      }

      private_dns_zones = {
        auto_registration_zone_enabled = false
      }

      hub_virtual_network = {
        name                    = "vnet-${var.prefix}-hub"
        address_space           = var.hub_address_space
        parent_id               = azurerm_resource_group.rg.id
        ddos_protection_plan_id = null
        tags                    = var.tags
      }
    }
  }
}
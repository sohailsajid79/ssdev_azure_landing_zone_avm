module "waf_policy" {
  source  = "Azure/avm-res-network-applicationgatewaywebapplicationfirewallpolicy/azurerm"
  version = "~> 0.1"
  count   = var.deploy_app_gateway ? 1 : 0

  name                = "waf-${var.prefix}-online"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  policy_settings = {
    enabled = true
    mode    = "Prevention"
  }

  managed_rules = {
    managed_rule_set = {
      owasp = {
        type    = "OWASP"
        version = "3.2"
      }
    }
  }

  tags = var.tags
}

module "app_gateway" {
  source  = "Azure/avm-res-network-applicationgateway/azurerm"
  version = "~> 0.4"
  count   = var.deploy_app_gateway ? 1 : 0

  name                = "agw-${var.prefix}-online"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  gateway_ip_configuration = {
    subnet_id = module.vnet.subnets["appgw"].resource_id
  }

  sku = {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 0 # autoscale
  }

  app_gateway_waf_policy_resource_id = module.waf_policy[0].resource_id

  public_ip_address_configuration = {
    public_ip_name = "pip-${var.prefix}-online-appgw"
  }

  frontend_ports = {
    http = {
      name = "port-80"
      port = 80
    }
  }

  backend_address_pools = {
    default = {
      name = "backend-default"
    }
  }

  backend_http_settings = {
    default = {
      name     = "http-settings-default"
      port     = 80
      protocol = "Http"
    }
  }

  http_listeners = {
    default = {
      name               = "listener-http"
      frontend_port_name = "port-80"
    }
  }

  request_routing_rules = {
    default = {
      name                       = "rule-default"
      rule_type                  = "Basic"
      http_listener_name         = "listener-http"
      backend_address_pool_name  = "backend-default"
      backend_http_settings_name = "http-settings-default"
      priority                   = 100
    }
  }

  tags = var.tags
}
module "avm-ptn-alz" {
  source            = "Azure/avm-ptn-alz/azurerm"
  version           = "~> 0.21"
  architecture_name = "alz"

  location = var.location

  parent_resource_id = var.tenant_id

  enable_telemetry = var.enable_telemetry

  subscription_placement = {
    platform = {
      subscription_id       = var.subscription_id
      management_group_name = "platform"
    }
  }

  management_group_hierarchy_settings = {
    default_management_group_name = "sandbox"
  }

  policy_default_values = null
}
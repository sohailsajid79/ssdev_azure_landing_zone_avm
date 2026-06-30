module "avm-ptn-alz" {
  source            = "Azure/avm-ptn-alz/azurerm"
  version           = "~> 0.21"
  architecture_name = "alz"

  location = var.location

  parent_resource_id = var.tenant_id

  enable_telemetry = var.enable_telemetry

  # causing timeout error. disabling the setting for now.   
  # management_group_hierarchy_settings = {
  #   default_management_group_name = var.intermediate_root_id
  # }

  policy_default_values = null
}
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

  # ALZ ships a default policy assignment called Enable-DDoS-VNET. It's a Modify policy, so it actively rewrites resources as they're created; injects a DDoS Protection Plan ID into every new virtual network in scope.
  # I am deliberately not going to deploy a DDoS Protection Plan, because it costs >£2K+ month. But the policy doesn't know that. With no real plan existing, the assignment falls back to a placeholder ID, where the policy tries to inject an invalid ID into a VNet at creation time, the creation fails. So a policy meant to protect VNets ends up blocking every VNet deployment.
  # Here is the fix; setting enforcement_mode = "DoNotEnforce" tells Azure Policy to keep evaluating the policy (so we still get compliance reporting) but to stop performing the mutation that breaks things.
  policy_assignments_to_modify = {
    connectivity = {
      policy_assignments = {
        Enable-DDoS-VNET = {
          enforcement_mode = "DoNotEnforce"
        }
      }
    }
  }

  policy_default_values = null
}
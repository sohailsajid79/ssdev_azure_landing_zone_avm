data "azurerm_billing_mca_account_scope" "this" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

module "subscriptions" {
  source          = "Azure/avm-ptn-alz-sub-vending/azure"
  version         = "~> 0.2"
  for_each        = var.subscriptions
  subscription_id = each.value.subscription_id

  location = var.location

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.this.id
  subscription_alias_name    = each.value.name
  subscription_display_name  = each.value.name
  subscription_workload      = "Production"
  subscription_tags          = var.tags

  subscription_management_group_association_enabled = true
  subscription_management_group_id                  = each.value.management_group_id

  role_assignment_enabled = true
  role_assignments = {
    ci_contributor = {
      principal_id   = var.ci_principal_id
      definition     = "Contributor"
      relative_scope = ""
    }
  }
}
resource "azuread_application_registration" "appreg" {
  display_name = "sp-${var.prefix}-alz-github-oidc"
}

resource "azuread_application_owner" "appreg_owner" {
  application_id  = azuread_application_registration.appreg.id
  owner_object_id = data.azurerm_client_config.current.object_id
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application_registration.appreg.client_id
  owners    = [data.azurerm_client_config.current.object_id]
}

resource "azuread_application_federated_identity_credential" "environments" {
  for_each       = toset(var.github_environments)
  application_id = azuread_application_registration.appreg.id
  display_name   = "github-env-${each.value}"
  description    = "GitHub Actions OIDC for environment ${each.value}"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_org}/${var.github_repo}:environment:${each.value}"
}

resource "azuread_application_federated_identity_credential" "main_branch" {
  application_id = azuread_application_registration.appreg.id
  display_name   = "github-branch-main"
  description    = "GitHub Actions OIDC for main branch (apply)"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/main"
}

resource "azuread_application_federated_identity_credential" "pull_request" {
  application_id = azuread_application_registration.appreg.id
  display_name   = "github-pull-request"
  description    = "GitHub Actions OIDC for pull requests (plan)"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_org}/${var.github_repo}:pull_request"
}

locals {
  subscription_ids = distinct(compact([
    var.platform_sub_id,
    var.landingzone_sub_id,
    var.management_sub_id,
  ]))
}

resource "azurerm_role_assignment" "github_subscriptions" {
  for_each = toset(local.subscription_ids)

  scope                = "/subscriptions/${each.value}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.sp.object_id
}

resource "azurerm_role_assignment" "github_tenant_root" {
  count                = var.grant_tenant_root_owner ? 1 : 0
  scope                = "/providers/Microsoft.Management/managementGroups/${var.root_tenant_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.sp.object_id
}
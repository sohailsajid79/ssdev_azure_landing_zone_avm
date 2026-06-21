output "github_actions_client_id" {
  description = "AZURE_CLIENT_ID"
  value       = azuread_application_registration.appreg.client_id
}

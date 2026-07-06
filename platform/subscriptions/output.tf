output "subscription_ids" {
  description = "Vended subscription IDs, consumed by downstream layer providers."
  value       = { for k, m in module.subscriptions : k => m.subscription_id }
}
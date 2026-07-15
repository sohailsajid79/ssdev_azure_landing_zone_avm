variable "location" {
  type    = string
  default = "uksouth"
}

variable "tenant_id" {
  type = string
}

variable "enable_telemetry" {
  type    = bool
  default = true
}

variable "subscription_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "dcr_change_tracking_id" {
  type = string
}

variable "dcr_vm_insights_id" {
  type = string
}

variable "dcr_defender_sql_id" {
  type = string
}

variable "ama_uami_id" {
  type = string
}

variable "ama_uami_name" {
  type    = string
  default = "uami-ama"
}

variable "connectivity_subscription_id" {
  type = string
}

variable "dns_zone_resource_group_name" {
  type    = string
  default = "rg-ss-dev-connectivity"
}

variable "security_contact_email" {
  type = string
}
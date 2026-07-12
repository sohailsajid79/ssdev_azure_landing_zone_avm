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

# variable "allowed_locations" {
#   type = list(string)
# }

variable "subscription_id" {
  type = string
}
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

variable "intermediate_root_id" {
  type    = string
  default = "ssdev"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.()-]{1,90}$", var.intermediate_root_id))
    error_message = "MG id must be 1-90 chars: letters, numbers, hyphens, underscores, periods, parentheses."
  }
}

variable "intermediate_root_display_name" {
  type        = string
  description = "Display name of the intermediate root management group."
  default     = "SS Dev Platform"
}


variable "allowed_locations" {
  type    = list(string)
  default = ["uksouth"]
}
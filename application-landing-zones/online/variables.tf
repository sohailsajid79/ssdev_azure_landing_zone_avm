variable "online_subscription_id" {
  type = string
}

variable "hub_vnet_id" {
  type        = string
  description = "resource ID of the hub VNet in the connectivity subscription"
}

variable "prefix" {
  type    = string
  default = "ss-dev"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "online_address_space" {
  type    = list(string)
  default = ["10.30.0.0/16"]
}

variable "deploy_app_gateway" {
  type        = bool
  default     = false
  description = "deliberately off; App Gateway WAF_v2 runs ~£300/month"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all online landing zone resources."
  default = {
    environment = "dev"
    managedBy   = "terraform"
    layer       = "online"
    project     = "alz-avm"
  }
}
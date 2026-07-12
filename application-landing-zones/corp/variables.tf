variable "corp_subscription_id" {
  type = string
}

variable "hub_vnet_id" {
  type = string
}

variable "prefix" {
  type    = string
  default = "ss-dev"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "corp_address_space" {
  type    = list(string)
  default = ["10.20.0.0/16"]
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all corp landing zone resources."
  default = {
    environment = "dev"
    managedBy   = "terraform"
    layer       = "corp"
    project     = "alz-avm"
  }
}
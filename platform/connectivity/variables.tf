variable "prefix" {
  type    = string
  default = "ss-dev"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "connectivity_subscription_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
    platform    = "alz"
    owner       = "devops"
    costCenter  = "sole-inc"
    managedBy   = "terraform"
  }
}

variable "hub_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

# Reserved for the firewall/gateway enablement phase — currently unused.
# Spoke CIDRs must sit outside the hub range (e.g. 10.11.0.0/16 corp,
# 10.12.0.0/16 online) since peered VNets cannot overlap.
# variable "gateway_subnet_prefix" {
#   type    = string
#   default = "10.10.0.0/24"
# }

# variable "azure_firewall_subnet_prefix" {
#   type    = string
#   default = "10.10.1.0/24"
# }
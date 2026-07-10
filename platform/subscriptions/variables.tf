variable "location" {
  type    = string
  default = "uksouth"
}

variable "platform_subscription_id" {
  type = string
}

variable "billing_account_name" {
  type = string
}

variable "billing_profile_name" {
  type = string
}

variable "invoice_section_name" {
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

variable "subscriptions" {
  type = map(object({
    name                = string
    management_group_id = string
    subscription_id     = optional(string, null)
  }))
  default = {
    management = {
      name                = "sub-ss-dev-management"
      management_group_id = "management"
      subscription_id     = "4b967947-aa67-4485-a8a4-7e878d231acc"
    }

    connectivity = { name = "sub-ss-dev-connectivity", management_group_id = "connectivity" }
    corp         = { name = "sub-ss-dev-corp", management_group_id = "corp" }
    online       = { name = "sub-ss-dev-online", management_group_id = "online" }
  }
}
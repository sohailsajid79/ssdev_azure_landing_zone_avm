variable "prefix" {
  type    = string
  default = "ss-dev"
}

variable "location" {
  type    = string
  default = "uksouth"
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

variable "log_analytics_sku" {
  type    = string
  default = "PerGB2018"
}

variable "log_retention_in_days" {
  type    = number
  default = 30
}
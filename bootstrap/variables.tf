variable "platform_sub_id" {
  type = string
}

variable "root_tenant_id" {
  type = string
}

variable "landingzone_sub_id" {
  type = string
}

variable "management_sub_id" {
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

variable "tags" {
  type        = map(string)
  description = "Tags applied to all bootstrap resources."
  default = {
    environment = "platform"
    managedBy   = "terraform"
    layer       = "bootstrap"
    project     = "alz-avm"
  }
}

variable "github_org" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_environments" {
  type    = list(string)
  default = ["prod", "nonprod"]
}

variable "grant_tenant_root_owner" {
  type    = bool
  default = false
}

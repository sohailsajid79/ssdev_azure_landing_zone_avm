terraform {
  required_version = ">= 1.12, < 2.0"

  required_providers {
    alz = {
      source  = "Azure/alz"
      version = "~> 0.21"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

provider "alz" {
  library_overwrite_enabled = true
  library_references = [
    {
      path = "platform/alz"
      ref  = "2026.04.2"
    },
    {
      custom_url = "${path.root}/lib"
    }
  ]
}

provider "azapi" {

}

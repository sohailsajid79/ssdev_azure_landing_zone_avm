terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.management_subscription_id
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

provider "azapi" {
  subscription_id = var.management_subscription_id
}
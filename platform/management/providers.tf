terraform {
  required_version = ">= 1.9, < 2.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}
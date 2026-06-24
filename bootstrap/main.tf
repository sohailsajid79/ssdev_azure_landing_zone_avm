data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-tfstate"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "str" {
  name                     = "strtfstate${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  shared_access_key_enabled = true


  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "str_container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.str.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "role_assign" {
  scope                = azurerm_storage_account.str.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "role_assign_contributor" {
  scope                = azurerm_storage_account.str.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
# BAD: Hardcoded blob storage URL in resource metadata
resource "azurerm_storage_container" "bad_hardcoded" {
  name                  = "data"
  storage_account_name  = "mystorageaccount"
  container_access_type = "private"

  metadata = {
    source_url = "https://externaldata.blob.core.windows.net/imports" # $Alert[iac/azure/hardcoded-blob-storage-reference]
  }
}

# BAD: Blob URL in a function app setting
resource "azurerm_function_app" "bad_function" {
  name                       = "my-function-app"
  location                   = "westus2"
  resource_group_name        = "my-rg"
  app_service_plan_id        = "/subscriptions/sub/providers/plan"
  storage_account_name       = "funcappstorage"
  storage_account_access_key = "key"

  app_settings = {
    "EXTERNAL_DATA_URL" = "https://danglingacct.blob.core.windows.net/data/config.json" # $Alert[iac/azure/hardcoded-blob-storage-reference]
  }
}

# BAD: Blob URL in a local value
locals {
  backup_url = "https://oldbackup.blob.core.windows.net/backups" # $Alert[iac/azure/hardcoded-blob-storage-reference]
}

# BAD: Blob URL in an output
output "data_endpoint" {
  value = "https://abandoned.blob.core.windows.net/public" # $Alert[iac/azure/hardcoded-blob-storage-reference]
}

# GOOD: Using a variable reference instead of hardcoded URL
resource "azurerm_storage_container" "good_variable" {
  name                  = "data"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}

# GOOD: No blob storage URL present
resource "azurerm_storage_account" "good_no_blob_url" {
  name                     = "mystorage"
  resource_group_name      = "my-rg"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# GOOD: Reference using interpolation (not a pure string literal)
resource "azurerm_storage_container" "good_interpolated" {
  name                 = "data"
  storage_account_name = var.storage_account_name

  metadata = {
    endpoint = "${var.storage_account_name}.blob.core.windows.net"
  }
}

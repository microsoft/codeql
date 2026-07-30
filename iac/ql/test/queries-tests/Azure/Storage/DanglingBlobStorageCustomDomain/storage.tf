# BAD: Custom domain pointing to a blob.core.windows.net endpoint
resource "azurerm_storage_account" "bad_custom_domain" {
  name                     = "mybadstorage"
  resource_group_name      = "my-rg"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  custom_domain {
    name = "mybadstorage.blob.core.windows.net" # $Alert[iac/azure/dangling-blob-storage-custom-domain]
  }
}

# BAD: Custom domain in a different resource type
resource "azurerm_cdn_endpoint" "bad_cdn" {
  name                = "mycdn"
  resource_group_name = "my-rg"
  location            = "westus2"
  profile_name        = "myprofile"

  custom_domain {
    name      = "cdn"
    host_name = "oldaccount.blob.core.windows.net" # $Alert[iac/azure/dangling-blob-storage-custom-domain]
  }
}

# GOOD: Custom domain using a proper CNAME, not a blob endpoint
resource "azurerm_storage_account" "good_custom_domain" {
  name                     = "mygoodstorage"
  resource_group_name      = "my-rg"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  custom_domain {
    name = "cdn.mycompany.com"
  }
}

# GOOD: No custom domain at all
resource "azurerm_storage_account" "good_no_domain" {
  name                     = "plainaccount"
  resource_group_name      = "my-rg"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

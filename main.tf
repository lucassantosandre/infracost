resource "azurerm_resource_group" "rgstorage" {
  name     = "storagerg"
  location = "brazilsouth"
}

resource "random_string" "random" {
  length  = 3
  special = false
  upper   = false
  number  = true

}

resource "azurerm_storage_account" "storagetf" {
  name                     = "tftreinamento${random_string.random.result}"
  resource_group_name      = "storagerg"
  location                 = "brazilsouth"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.rgstorage]
}

resource "azurerm_storage_container" "container" {
  name                 = "terraform"
  storage_account_name = azurerm_storage_account.storagetf.name
  depends_on           = [azurerm_storage_account.storagetf]
}

output "blobstorage-name" {
  sensitive = true
  value     = azurerm_storage_account.storagetf.name
}

output "blobstorage-chave-primaria" {
  sensitive = true
  value     = azurerm_storage_account.storagetf.primary_access_key
}

output "blobstorage-chave-secundaria" {
  sensitive = true
  value     = azurerm_storage_account.storagetf.secondary_access_key
}
# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "vms-rs" {
  name     = var.rs-name
  location = var.rs-location
}
# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}
  subscription_id = var.my-subscription_id
}

# Random String Resource
resource "random_string" "myrandom" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

# Resource-1: Azure Resource Group

resource "azurerm_resource_group" "vms-rs" {
  name     = var.rs-name
  location = var.rs-location
}

module "vm" {
  source                                = "./modules/vm"
  location                              = azurerm_resource_group.vms-rs.location
  resource_group_name                   = azurerm_resource_group.vms-rs.name
  vm_linux_name                         = "linuxvm-1"
  vm_linux_computer_name                = "linuxvm-1"
  vm_linux_size                         = "Standard_B1s" # Change to an available size, e.g., Standard_B1s
  vm_linux_admin_username               = "azureuser"
  vm_linux_admin_password               = "Segura123"
  network_interface_ids_from_networking = module.networking.network_interface_ids
}

module "networking" {
  source                 = "./modules/networking"
  location_networking    = azurerm_resource_group.vms-rs.location
  resource_group_name_nw = azurerm_resource_group.vms-rs.name
  virtual_network_name   = "vms-vnet-1"
  address_space          = "10.0.0.0/16"
  subnet_name            = "vms-subnet"
  subnet_prefix          = "10.0.2.0/24"
  public_ip_name         = "vms-public-ip"
  domain_name_label      = "vms-practice"
  vmnic_name             = "vmnic"
  vm_nsg_name            = "vms-nsg"
  random_string          = random_string.myrandom.id
}

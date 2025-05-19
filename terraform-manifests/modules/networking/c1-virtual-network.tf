# Create Virtual Network
resource "azurerm_virtual_network" "vms-vnet" {
  name                = var.virtual_network_name
  address_space       = [var.address_space]
  location            = var.location_networking
  resource_group_name = var.resource_group_name_nw
}

# Create Subnet
resource "azurerm_subnet" "vms-subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name_nw
  virtual_network_name = azurerm_virtual_network.vms-vnet.name
  address_prefixes     = [var.subnet_prefix]
}

# Create Public IP Address
resource "azurerm_public_ip" "vms-publicip" {

  # We use count here to create multiple public IP addresses;
  # Each public ip addres must have a unique domain name label and unique name
  name                = "${var.public_ip_name}"
  resource_group_name = var.resource_group_name_nw
  location            = var.location_networking
  allocation_method   = "Static"
  domain_name_label   = "${var.domain_name_label}-${var.random_string}"
  tags = {
    environment = "Dev"
  }
}


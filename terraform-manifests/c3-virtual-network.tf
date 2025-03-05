# Create Virtual Network
resource "azurerm_virtual_network" "vms-vnet" {
  name                = var.virtual_network_name
  address_space       = [var.address_space]
  location            = azurerm_resource_group.vms-rs.location
  resource_group_name = azurerm_resource_group.vms-rs.name
}

# Create Subnet
resource "azurerm_subnet" "vms-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vms-rs.name
  virtual_network_name = azurerm_virtual_network.vms-vnet.name
  address_prefixes     = [var.subnet_prefix]
}

# Create Public IP Address
resource "azurerm_public_ip" "vms-publicip" {

  # We use count here to create multiple public IP addresses;
  # Each public ip addres must have a unique domain name label and unique name
  count               = 2
  name                = "${var.public_ip_name}-${count.index}"
  resource_group_name = azurerm_resource_group.vms-rs.name
  location            = azurerm_resource_group.vms-rs.location
  allocation_method   = "Static"
  domain_name_label   = "${var.domain_name_label}-${count.index}-${random_string.myrandom.id}"
  tags = {
    environment = "Dev"
  }
}


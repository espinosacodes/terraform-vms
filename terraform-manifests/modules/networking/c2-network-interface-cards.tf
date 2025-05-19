# Create Network Interface
resource "azurerm_network_interface" "vmnic" {
  name                = "${var.vmnic_name}"
  location            = var.location_networking
  resource_group_name = var.resource_group_name_nw

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vms-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vms-publicip.id
  }
}

# Create Network Security Group and Rule
resource "azurerm_network_security_group" "vms-nsg-linux" {
  name                = "${var.vm_nsg_name}-linux"
  location            = var.location_networking
  resource_group_name = var.resource_group_name_nw

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "sonarqube"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Associate NSG with Network Interface
# Must indicate the correct index of the NIC in order to display the vm.
resource "azurerm_network_interface_security_group_association" "vms-nsg-association-linux" {
  network_interface_id      = azurerm_network_interface.vmnic.id
  network_security_group_id = azurerm_network_security_group.vms-nsg-linux.id
}
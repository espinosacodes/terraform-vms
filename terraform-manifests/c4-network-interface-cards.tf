# Create Network Interface
resource "azurerm_network_interface" "vmnic" {
  count               = 2
  name                = "${var.vmnic_name}-${count.index}"
  location            = azurerm_resource_group.vms-rs.location
  resource_group_name = azurerm_resource_group.vms-rs.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vms-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vms-publicip[count.index].id
  }
}

# Create Network Security Group and Rule
resource "azurerm_network_security_group" "vms-nsg-linux" {
  name                = "${var.vm_nsg_name}-linux"
  location            = azurerm_resource_group.vms-rs.location
  resource_group_name = azurerm_resource_group.vms-rs.name

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

}


resource "azurerm_network_security_group" "vms-nsg-windows" {
  name                = "${var.vm_nsg_name}-windows"
  location            = azurerm_resource_group.vms-rs.location
  resource_group_name = azurerm_resource_group.vms-rs.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Associate NSG with Network Interface
# Must indicate the correct index of the NIC in order to display the vm.
resource "azurerm_network_interface_security_group_association" "vms-nsg-association-linux" {
  network_interface_id      = azurerm_network_interface.vmnic[0].id
  network_security_group_id = azurerm_network_security_group.vms-nsg-linux.id

}

resource "azurerm_network_interface_security_group_association" "vms-nsg-association-windows" {

  network_interface_id      = azurerm_network_interface.vmnic[1].id
  network_security_group_id = azurerm_network_security_group.vms-nsg-windows.id

}
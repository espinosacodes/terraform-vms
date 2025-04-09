# Resource: Azure Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = var.vm_linux_name
  computer_name                   = var.vm_linux_computer_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_linux_size
  admin_username                  = var.vm_linux_admin_username
  admin_password                  = var.vm_linux_admin_password
  disable_password_authentication = false
  network_interface_ids           = [var.network_interface_ids_from_networking[0]]

  os_disk {
    name                 = "windowsosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

}


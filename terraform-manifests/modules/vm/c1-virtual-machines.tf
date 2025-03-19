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
    name                 = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}

#Resource: Windows Virtual Machine 

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name = var.vm_windows_name
  #If we don't  set the computer_name, may occurr a certification problem when connecting with the windows vm using RDP.
  computer_name         = var.vm_windows_computer_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_windows_size
  admin_username        = var.vm_windows_admin_username
  admin_password        = var.vm_windows_admin_password
  network_interface_ids = [var.network_interface_ids_from_networking[1]]

  os_disk {
    name                 = "windowsosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }


  # Enable automatic updates.
  patch_mode = "AutomaticByOS"
}
# Resource: Azure Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                  = var.vm_linux_name
  computer_name         = var.vm_linux_computer_name
  resource_group_name   = azurerm_resource_group.vms-rs.name
  location              = azurerm_resource_group.vms-rs.location
  size                  = var.vm_linux_size
  admin_username        = var.vm_linux_admin_username
  network_interface_ids = [azurerm_network_interface.vmnic[0].id]
  admin_ssh_key {
    username   = var.vm_linux_admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

}

#Resource: Windows Virtual Machine 

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name = var.vm_windows_name
  #If we don't  set the computer_name, may occurr a certification problem when connecting with the windows vm using RDP.
  computer_name         = var.vm_windows_computer_name
  resource_group_name   = azurerm_resource_group.vms-rs.name
  location              = azurerm_resource_group.vms-rs.location
  size                  = var.vm_windows_size
  admin_username        = var.vm_windows_admin_username
  admin_password        = var.vm_windows_admin_password
  network_interface_ids = [azurerm_network_interface.vmnic[1].id]

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


  # Enable automatic updates.
  patch_mode = "AutomaticByOS"
}
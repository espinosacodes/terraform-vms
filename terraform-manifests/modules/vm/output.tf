output "linux_vm_id" {
  description = "ID de la máquina virtual Linux"
  value       = azurerm_linux_virtual_machine.linuxvm.id
}

output "windows_vm_id" {
  description = "ID de la máquina virtual Windows"
  value       = azurerm_windows_virtual_machine.windows_vm.id
}

output "subnet_id" {
  description = "ID de la subred"
  value       = azurerm_subnet.vms-subnet.id
}

output "public_ips" {
  description = "Lista de direcciones IP públicas"
  value       = azurerm_public_ip.vms-publicip[*].id
}

output "network_interface_ids" {
  description = "Lista de IDs de interfaces de red"
  value       = azurerm_network_interface.vmnic[*].id
}


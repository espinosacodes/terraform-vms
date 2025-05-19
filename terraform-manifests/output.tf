output "linux_vm_ip" {
  description = "Lista de direcciones IP públicas"
  value       = module.networking.public_ips
}

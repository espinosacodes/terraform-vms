variable "location" {
  description = "Ubicación de los recursos en Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "vm_linux_name" {
  description = "Nombre de la máquina virtual Linux"
  type        = string
}

variable "vm_linux_computer_name" {
  description = "Nombre del equipo en la VM Linux"
  type        = string
}

variable "vm_linux_size" {
  description = "Tamaño de la VM Linux"
  type        = string
}

variable "vm_linux_admin_username" {
  description = "Usuario administrador de la VM Linux"
  type        = string
}

variable "vm_linux_admin_password" {
  description = "Contraseña del administrador de la VM Linux"
  type        = string
  sensitive   = true
}
variable "network_interface_ids_from_networking" {
  description = "Lista de IDs de las interfaces de red"
  type        = list(string)
}

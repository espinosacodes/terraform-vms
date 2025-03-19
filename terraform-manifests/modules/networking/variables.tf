variable "location_networking" {
  description = "Ubicación de los recursos en Azure"
  type        = string
}

variable "resource_group_name_nw" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "virtual_network_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones de la red virtual"
  type        = string
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
}

variable "subnet_prefix" {
  description = "Prefijo de la subred"
  type        = string
}

variable "public_ip_name" {
  description = "Nombre base para las IPs públicas"
  type        = string
}

variable "domain_name_label" {
  description = "Etiqueta para el nombre de dominio de la IP pública"
  type        = string
}

variable "vmnic_name" {
  description = "Nombre base para las interfaces de red"
  type        = string
}

variable "vm_nsg_name" {
  description = "Nombre base para los grupos de seguridad de red"
  type        = string
}

variable "random_string" {
  description = "Referencia al recurso de cadena aleatoria"
  type        = any
}

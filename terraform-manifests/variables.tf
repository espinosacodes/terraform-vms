variable "my-subscription_id" {

  type        = string
  description = "Contains the value of my subscription."

}

# Resource group

variable "rs-location" {

  type        = string
  description = "Contains information about the rs location."

}

variable "rs-name" {

  type        = string
  description = "Contains information about the rs name."

}

# Network staff 


variable "virtual_network_name" {

  type        = string
  description = "Define the virtual network name."

}

variable "address_space" {

  type        = string
  description = "Define the base ip for vms."

}

variable "subnet_name" {

  type        = string
  description = "Define the subnet name."

}

variable "subnet_prefix" {

  type        = string
  description = "Define the subnet value applied to the virtual  network."

}

variable "public_ip_name" {

  type        = string
  description = "Define the public ip value."

}

variable "domain_name_label" {

  type        = string
  description = "Define the name that will be display on the domain first part."

}

variable "vmnic_name" {

  type        = string
  description = "Define the network interface name prefix."

}


variable "vm_nsg_name" {

  type        = string
  description = "Define the name of the Network Security Group."


}

# Linux vm

variable "vm_linux_name" {

  type        = string
  description = "Define the name of the virtual machine."

}

variable "vm_linux_computer_name" {

  type        = string
  description = "Define the computer name of the virtual machine."

}

variable "vm_linux_size" {

  type        = string
  description = "Define the size of the virtual machine."

}

variable "vm_linux_admin_username" {

  type        = string
  description = "Define the admin username of the virtual machine."

}

# Windows vm

variable "vm_windows_name" {

  type        = string
  description = "Define the name of the virtual machine."

}

variable "vm_windows_computer_name" {

  type        = string
  description = "Define the computer name of the virtual machine."

}

variable "vm_windows_size" {

  type        = string
  description = "Define the size of the virtual machine."

}

variable "vm_windows_admin_username" {

  type        = string
  description = "Define the admin username of the virtual machine."

}

variable "vm_windows_admin_password" {

  type        = string
  description = "Define the admin password of the virtual machine."

}



variable "vm_linux_admin_password" {
  description = "Password for the Linux VM admin user"
  type        = string
  sensitive   = true
}
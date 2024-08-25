variable "zones" {
  description = "Yandex Cloud Zones for provisoned resources."
  type        = set(string)
}

variable "linux_vm_name" {
  description = "Name of the Linux VM."
  type        = string
}

variable "subnets" {
  description = "(Optional) - A map of subnet names to their CIDR block ranges."
  type        = map(list(string))
  default = {
    # "ru-central1-a" = ["192.168.10.0/24"],
    "ru-central1-b" = ["192.168.11.0/24"],
    "ru-central1-d" = ["192.168.12.0/24"]    
  }
}

variable "vpc_network_name" {
  description = "(Optional) - Name of the VPC network."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Name prefix for project."
  type        = string
}
variable "secondary_disks" {
  description = "(Optional) - Configuration for secondary disks."
  type        = object({
    count = number
    name  = string
    type  = string
    size  = number
  })
  default     = {
    count = 2
    name  = "secondary-disk"
    type  = "network-hdd"
    size  = 10
  }
}

variable "linux_vm_name" {
  description = "Name of the Linux VM."
  type        = string
}

variable "boot_disk_name" {
  description = "(Optional) - Name of the boot disk."
  type        = string
  default     = null
}

variable "instance_resources" {
  description = <<EOF
    (Optional) Specifies the resources allocated to an instance.
      - `platform_id`: The type of virtual machine to create.If not provided, it defaults to `standard-v3`.
      - `cores`: The number of CPU cores allocated to the instance.
      - `memory`: The amount of memory (in GiB) allocated to the instance.
      - `disk`: Configuration for the instance disk.
        - `disk_type`: The type of disk for the instance. If not provided, it defaults to `network-ssd`.
        - `disk_size`: The size of the disk (in GiB) allocated to the instance. If not provided, it defaults to 15 GiB."
  EOF

  type        = object({
    platform_id = optional(string, "standard-v3")
    cores       = number
    memory      = number
    disk = optional(object({
      disk_type = optional(string, "network-ssd")
      disk_size = optional(number, 15)
    }), {})
  })
}

variable "ydb_connect_string" {
  description = "Endpoint for the YDB connection"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix for project."
  type        = string
}

variable "bucket_domain_name" {
  description = "Bucket domain name"
  type        = string
}

variable "public_subnets" { 
  description = "Public subnets"
  type = map(object({
    subnet_id      = string
    name           = string
    zone           = string
    v4_cidr_blocks = list(string)
    folder_id      = string
  }))
}

variable "nat_ip_addresses" {
  type        = map(string)
}

variable "zones" {
  description = "Yandex Cloud Zones for provisoned resources."
  type        = set(string)
}

variable "image_id" {
  description = "(Optional) - Boot disk image id. If not provided, it defaults to Ubuntu 22.04 LTS image id"
  type        = string
  default     = "fd8ba9d5mfvlncknt2kd"
}
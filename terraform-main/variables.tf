variable "name_prefix" {
  description = "(Optional) - Name prefix for project."
  type        = string
  default     = "project"
}

variable "zones" {
  description = "(Optional) - Yandex Cloud Zones for provisoned resources."
  type        = set(string)
  default     = ["ru-central1-b", "ru-central1-d"]
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

  type = object({
    platform_id = optional(string, "standard-v3")
    cores       = number
    memory      = number
    disk        = optional(object({
      disk_type = optional(string, "network-ssd")
      disk_size = optional(number, 15)
    }), {})
  })
}

variable "linux_vm_name" {
  description = "(Optional) - Name of the Linux VM."
  type        = string
  default     = null
}
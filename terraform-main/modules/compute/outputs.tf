output "boot_disk_ids" {
  description = "The IDs of the boot disks created for the instances."
  value       = {
    for disk in yandex_compute_disk.boot_disk :
    disk.name => disk.id...
  }
}

output "instance_ids" {
  description = "The IDs of the Yandex Compute instances."
  value       = {
    for instance in yandex_compute_instance.this :
    instance.name => instance.id...
  }
}

output "serial_port_files" {
  description = "The Serial port's output files."
  value       = [
    for instance in yandex_compute_instance.this :
    "serial_output_${instance.name}.txt"
  ]
}
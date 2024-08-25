output "boot_disk_ids" {
  description = "The IDs of the boot disks created for the instances."
  value       = module.compute.boot_disk_ids
}

output "instance_ids" {
  description = "The IDs of the Yandex Compute instances."
  value       = module.compute.instance_ids
}

output "subnet_ids" {
  description = "The IDs of the VPC subnets used by the Yandex Compute instances."
  value       = module.vpc.subnet_ids
}

output "ydb_id" {
  description = "The ID of the Yandex Managed Service for YDB instance."
  value       = module.ydb.ydb_id
}

output "service_account_id" {
  description = "The ID of the Yandex IAM service account."
  value       = module.s3.service_account_id
}

output "bucket_name" {
  description = "The name of the Yandex Object Storage bucket."
  value       = module.s3.bucket_name
} 

# output "access_key" {
#     description = "The public access key"
#     sensitive   = true
#     value       = yandex_iam_service_account_static_access_key.this.access_key
# }

# output "acess_secret_key" {
#     description = "The secret access key"
#     sensitive   = true
#     value       = yandex_iam_service_account_static_access_key.this.secret_key
# }

output "instance_public_ip_addresses" {
  description = "The external IP addresses of the instances."
  value       = module.vpc.instance_public_ip_addresses
}

output "serial_port_files" {
  description = "The Serial port's output files."
  value       = module.compute.serial_port_files
}
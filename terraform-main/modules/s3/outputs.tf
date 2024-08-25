output "bucket_domain_name" {
  description = "S3 bucket domain name."
  value       = module.s3.bucket_domain_name
}

output "bucket_name" {
  description = "The name of the Yandex Object Storage bucket."
  value       = module.s3.bucket_name
}

output "service_account_id" {
  description = "The ID of the Yandex IAM service account."
  value       = module.s3.storage_admin_service_account_id
}
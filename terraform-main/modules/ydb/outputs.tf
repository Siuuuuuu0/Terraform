output "ydb_full_endpoint" {
    description = "YDB full connection endpoint."
    value       = yandex_ydb_database_serverless.this.ydb_full_endpoint
}

output "ydb_id" {
  description = "The ID of the Yandex Managed Service for YDB instance."
  value       = yandex_ydb_database_serverless.this.id
}
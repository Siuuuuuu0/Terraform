# Локальные значения имен ресурсов
locals {
  ydb_serverless_name = var.ydb_serverless_name != null ? var.ydb_serverless_name : "${var.name_prefix}-ydb-serverless"
}

# Создание Yandex Managed Service for YDB
resource "yandex_ydb_database_serverless" "this" {
  name = local.ydb_serverless_name
}
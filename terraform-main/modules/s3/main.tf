# Локальные значения имен ресурсов
locals {  
  bucket_name = var.bucket_name != null ? var.bucket_name : join("-", [var.name_prefix, "terraform", "bucket", random_string.bucket_name.result])
}

# Модуль для создания бакета
module "s3" {
  source = "github.com/terraform-yc-modules/terraform-yc-s3.git?ref=9fc2f832875aefb6051a2aa47b5ecc9a7ea8fde5" # Commit hash for 1.0.2

  bucket_name = local.bucket_name
}

# Генерация случайного имени для бакета
resource "random_string" "bucket_name" {
  length  = 8
  special = false
  upper   = false
}
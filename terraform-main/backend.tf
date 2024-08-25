# terraform {
#   backend "s3" {
#     region         = "ru-central1"
#     bucket         = "vadim-lock-bucket"
#     key            = "terraform.tfstate"

#     dynamodb_table = "state-lock-table"

#     endpoints = {
#       s3       = "https://storage.yandexcloud.net",
#       dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gvd3h37ertmtsq7gr9/etn5hqsa8jf88d4dp39q"
#     }

#     skip_credentials_validation = true
#     skip_region_validation      = true
#     skip_requesting_account_id  = true
#     skip_s3_checksum            = true
#   }
# }
terraform {
  backend "s3" {
    region         = "ru-central1"
    bucket         = "vadim-lock-bucket-cicd"
    key            = "terraform.tfstate"

    dynamodb_table = "state-lock-table"

    endpoints = {
      s3       = "https://storage.yandexcloud.net",
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gvd3h37ertmtsq7gr9/etnj0icrf9hd0k30r22u"
    }

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
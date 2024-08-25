variable "ydb_serverless_name" {
  description = "(Optional) - Name of the YDB serverless."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Name prefix for project."
  type        = string
}
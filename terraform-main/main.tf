# Локальные значения имен ресурсов
locals {
  linux_vm_name       = var.linux_vm_name != null ? var.linux_vm_name : "${var.name_prefix}-linux-vm"
  # subnet_list         = "${flatten(values(var.subnets))}"
}

module "vpc" {
  source        = "./modules/vpc"

  zones         = var.zones
  linux_vm_name = local.linux_vm_name
  name_prefix   = var.name_prefix
}

module "s3" {
  source      = "./modules/s3"
  name_prefix = var.name_prefix
}

module "ydb" {
  source      = "./modules/ydb"

  name_prefix = var.name_prefix
}

module "compute" {
  source             = "./modules/compute"

  linux_vm_name      = local.linux_vm_name
  ydb_connect_string = module.ydb.ydb_full_endpoint
  name_prefix        = var.name_prefix
  bucket_domain_name = module.s3.bucket_domain_name
  public_subnets     = module.vpc.public_subnets
  nat_ip_addresses   = module.vpc.nat_ip_addresses
  zones              = var.zones
  instance_resources = var.instance_resources    
  security_group_ids = [module.vpc.security_group_id]  
}

# # Таймер для отсчёта 180 секунд после создания ВМ
# resource "time_sleep" "wait_180_seconds" {
#   create_duration = "180s"

#   depends_on = [ yandex_compute_instance.this ]
# }

# Вывод последовательного порта через YC CLI спустя 180 секунд после создания ВМ - провижининг заменён на cloud-init
# resource "terraform_data" "get_serial_output" {
#   for_each = yandex_compute_instance.this

#   provisioner "local-exec" {
#     command = "yc compute instance get-serial-port-output --id ${each.value.id} --folder-id ${var.folder_id} > serial_output_${each.value.name}.txt"
#   }

#   depends_on = [ time_sleep.wait_180_seconds ]
# }
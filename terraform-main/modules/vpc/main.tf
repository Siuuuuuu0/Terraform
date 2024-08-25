# Локальные значения имен ресурсов
locals {
  vpc_network_name    = var.vpc_network_name != null ? var.vpc_network_name : "${var.name_prefix}-private"
}

# Создание статического IP-адреса для каждой зоны (квота на два адреса в облаке)
resource "yandex_vpc_address" "this" {
  for_each = var.zones

  name = length(var.zones) > 1 ? "${var.linux_vm_name}-address-${substr(each.value, -1, 0)}" : "${var.linux_vm_name}-address"
  external_ipv4_address {
    zone_id = each.value
  }
} 

# Модуль для создания сети и подсетей
module "net" {
  source = "github.com/terraform-yc-modules/terraform-yc-vpc.git?ref=19a9893f25b2536cea3c9c15c180c905ea37bf9c" # Commit hash for 1.0.7

  network_name = local.vpc_network_name
  create_sg    = false

  public_subnets = [
    for zone in var.zones :
    {
      v4_cidr_blocks = var.subnets[zone]
      zone           = zone
      name           = zone
    }
  ]
}
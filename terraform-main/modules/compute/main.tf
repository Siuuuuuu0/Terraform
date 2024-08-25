locals {
  boot_disk_name      = var.boot_disk_name != null ? var.boot_disk_name : "${var.name_prefix}-boot-disk"
  linux_vm_name       = var.linux_vm_name != null ? var.linux_vm_name : "${var.name_prefix}-linux-vm"
}

# Создание ВМ для каждой зоны
resource "yandex_compute_instance" "this" {
  for_each = var.zones

  name                      = length(var.zones) > 1 ? "${local.linux_vm_name}-${substr(each.value, -1, 0)}" : local.linux_vm_name
  allow_stopping_for_update = true
  platform_id               = var.instance_resources.platform_id
  zone                      = each.value

  resources {
    cores  = var.instance_resources.cores
    memory = var.instance_resources.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk[each.value].id
  }

  network_interface {
    subnet_id = {
      for subnet in var.public_subnets :
      subnet.zone => subnet.subnet_id
    }[each.value]
    # nat            = true
    # nat_ip_address = var.nat_ip_addresses[each.value]
    security_group_ids = var.security_group_ids
  }

  metadata = {
    user-data = templatefile("${path.module}/../../templates/cloud-init.yaml.tftpl", {
      vm_name = length(var.zones) > 1 ? "${local.boot_disk_name}-${substr(each.value, -1, 0)}" : local.boot_disk_name,
      ydb_connect_string = var.ydb_connect_string,
      bucket_domain_name = var.bucket_domain_name
    })
  }

  labels = {
    cpu = format("%d", var.instance_resources.cores)
    memory = format("%d", var.instance_resources.memory)
  }

  # Динамическое подлючение вторичных дисков в зависимости от зоны
  dynamic "secondary_disk" {
    for_each = each.value == "ru-central1-b" ? yandex_compute_disk.secondary_disk_b : each.value == "ru-central1-d" ? yandex_compute_disk.secondary_disk_d : []
    content {
      disk_id = try(secondary_disk.value.id, null)
    }
  }  
}

# Создание основных дисков для каждой зоны
resource "yandex_compute_disk" "boot_disk" {
  for_each = var.zones

  name     = length(var.zones) > 1 ? "${local.boot_disk_name}-${substr(each.value, -1, 0)}" : local.boot_disk_name
  zone     = each.value
  image_id = var.image_id

  type = var.instance_resources.disk.disk_type
  size = var.instance_resources.disk.disk_size
}

# Создание вторичных дисков для зон Б и Д
resource "yandex_compute_disk" "secondary_disk_b" {
  count = contains(var.zones, "ru-central1-b") ? var.secondary_disks.count : 0

  name = "${var.secondary_disks.name}-b-${count.index}"
  zone = "ru-central1-b"

  type = var.secondary_disks.type
  size = var.secondary_disks.size
}

resource "yandex_compute_disk" "secondary_disk_d" {
  count = contains(var.zones, "ru-central1-d") ? var.secondary_disks.count : 0

  name = "${var.secondary_disks.name}-d-${count.index}"
  zone = "ru-central1-d"

  type = var.secondary_disks.type
  size = var.secondary_disks.size
} 

# Таймер для отсчёта 120 секунд после создания ВМ
resource "time_sleep" "wait_120_seconds" {
  create_duration = "120s"

  depends_on = [yandex_compute_instance.this]
}

# Создание снимка спустя 120 секунд после создания ВМ 
resource "yandex_compute_snapshot" "initial" {
  for_each = yandex_compute_disk.boot_disk

  name           = "${each.value.name}-initial"
  source_disk_id = each.value.id

  depends_on = [time_sleep.wait_120_seconds]
}
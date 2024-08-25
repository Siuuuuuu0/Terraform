output "nat_ip_addresses" {
  description = "Nat Ip addresses."
  value       = {
    for k, v in yandex_vpc_address.this : k => v.external_ipv4_address[0].address
  }
}

output "instance_public_ip_addresses" {
  description = "The external IP addresses of the instances."
  value       = {
    for address in yandex_vpc_address.this :
    address.name => address.external_ipv4_address[0].address...
  }
}

output "subnet_ids" {
  description = "The IDs of the VPC subnets used by the Yandex Compute instances."
  value       = {
    for cidr_block, subnet_info in module.net.public_subnets :
    subnet_info.name => subnet_info.subnet_id
  }
}

output "public_subnets" {
  description = "Public subnets for the VM instances."
  value       = module.net.public_subnets
}
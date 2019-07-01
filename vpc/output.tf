output "vpc_id" {
  description = "VPC ID"
  value = "${module.subnet.vpc_id}"
}
output "nat_gateways_allocation_ids" {
  description = "NAT Gateway Allocation IDs"
  value = "${aws_eip.nat_gateway_eip.*.id}"
}

output "nat_gateways_public_ips" {
  description = "NAT Gateways Public IP"
  value = "${aws_eip.nat_gateway_eip.*.public_ip}"
}
output "public_subnet_ids" {
  description = "Public Subnet ID"
  value = "${module.subnet.public_subnet_ids}"
}

output "app_subnet_ids" {
  description = "Private Subnet ID"
  value = "${module.subnet.app_subnet_ids}"
}

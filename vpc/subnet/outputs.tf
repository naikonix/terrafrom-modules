output "vpc_id" {
  description = "VPC ID"
  value = "${aws_vpc.main.*.id}"
}

output "public_subnet_ids" {
  description = "Public Subnet ID"
  value = "${module.public_network.public_subnet_id}"
}


output "app_subnet_ids" {
  description = "Private Subnet ID"
  value = "${module.app_private_network.subnet_ids}"
}


output "private_route_table_ids" {
  description = "Private Route Table IDs"
  value = "${module.app_private_network.route_table_ids}"
}

output "db_subnet_ids" {
  description = "DB Private Subnet ID"
  value = "${module.db_private_network.subnet_ids}"
}

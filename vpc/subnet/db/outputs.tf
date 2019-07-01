output "subnet_ids" {
  description = "Subnet IDs"
  value = "${aws_subnet.private_subnets.*.id}"
}

output "route_table_ids" {
  description = "Route Table IDs"
  value = "${aws_route_table.private_route_tables.*.id}"
}

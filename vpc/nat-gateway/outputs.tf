output "nat_gateway_public_ip" {
  description = "NAT Gateway Public IP"
  value = "${aws_nat_gateway.nat_gateway.*.public_ip}"
}

output "nat_gateway_private_ip" {
  description = "NAT Gateway Private IP"
  value = "${aws_nat_gateway.nat_gateway.*.private_ip}"
}

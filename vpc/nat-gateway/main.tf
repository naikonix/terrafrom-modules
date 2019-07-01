//Nat Gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = "${var.nat_gateway_count}"
  allocation_id = "${element(var.nat_gateways_allocation_ids, count.index)}"
  subnet_id     = "${var.public_subnet_ids[count.index]}"

  tags = "${merge(
    var.common_tags,
    map(
    "Name" ,"${var.project_name_prefix}"
      )
  )}"
}

//Route to the internet using Nat gateway
resource "aws_route" "nat_internet_access" {
  #count                  = "${var.subnet_association_count}"
  count                   = 1
  depends_on             = ["aws_nat_gateway.nat_gateway"]
  route_table_id         = "${element(var.associate_route_table_ids, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
}


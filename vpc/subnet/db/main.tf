resource "aws_subnet" "private_subnets" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${lookup(var.private_subnets[count.index], "cidr")}"
  availability_zone = "${lookup(var.private_subnets[count.index], "az")}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-db-private-${count.index + 1}"
      )
  )}"
}

resource "aws_route_table" "private_route_tables" {
  vpc_id = "${var.vpc_id}"
  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-db-private"
      )
  )}"
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_tables.*.id, count.index)}"
}


resource "aws_db_subnet_group" "this" {
  count      = "${length(var.private_subnets) > 0 ? 1 : 0 }"
  name       = "${var.project_name_prefix}-db"
  subnet_ids = "${aws_subnet.private_subnets.*.id}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-db-private"
      )
  )}"
}
resource "aws_subnet" "public_subnets" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${lookup(var.public_subnets[count.index], "cidr")}"
  map_public_ip_on_launch = true
  availability_zone       = "${lookup(var.public_subnets[count.index], "az")}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-public-${count.index + 1}"
      )
  )}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}"
      )
  )}"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${var.vpc_id}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-public"
      )
  )}"
}

resource "aws_route" "igw_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

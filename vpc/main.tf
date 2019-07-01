locals {
  project_name_prefix = "${var.project_name_prefix}"
  common_tags = "${var.common_tags}"
}

module "subnet" {
  source              = "./subnet/"
  project_name_prefix = "${local.project_name_prefix}"
  common_tags         = "${local.common_tags}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnets      = "${var.public_subnets}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  app_private_subnets = "${var.app_private_subnets}"
  db_private_subnets  = "${var.db_private_subnets}"
}
resource "aws_eip" "nat_gateway_eip" {
  count = "${local.nat_gateway_count * var.create_nat_gateway_eip}"
  vpc   = true

  tags = "${merge(
    local.common_tags,
    map(
      "Name" ,"${local.project_name_prefix}"
      )
  )}"
}
module "nat_gateway" {
  source                      = "./nat-gateway/"
  project_name_prefix         = "${local.project_name_prefix}"
  common_tags                 = "${local.common_tags}"
  public_subnet_ids           = "${module.subnet.public_subnet_ids}"
  nat_gateways_allocation_ids = "${aws_eip.nat_gateway_eip.*.id}"
  associate_route_table_ids   = "${module.subnet.private_route_table_ids}"
  nat_gateway_count           = "${local.nat_gateway_count}"
  subnet_association_count    = "${local.subnet_association_count}"
}

locals {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}"
      )
  )}"
}

module "public_network" {
  source              = "./public"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${var.common_tags}"
  vpc_id         = "${local.vpc_id}"
  public_subnets = "${var.public_subnets}"
}
module "app_private_network" {
  source              = "./private"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${var.common_tags}"
  vpc_id              = "${local.vpc_id}"
  private_subnets     = "${var.app_private_subnets}"
}

module "db_private_network" {
  source              = "./db"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${merge(var.common_tags,map("IsDBSubnet" ,"True"))}"
  vpc_id              = "${local.vpc_id}"
  private_subnets     = "${var.db_private_subnets}"
}




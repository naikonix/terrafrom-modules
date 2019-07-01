variable "vpc_cidr" {
  description = "CIDR for VPC"
  default = ""
}

variable "public_subnets" {
  description = "Public Subnet List of map with respective AZ and CIDR"
  type = "list"
}

variable "app_private_subnets" {
  description = "Private Subnet (Non-DB Subnet) List of map with respective AZ and CIDR"
  type = "list"
}
variable "db_private_subnets" {
  description = "Private DB Subnet List of map with respective AZ and CIDR"
  type = "list"
  default = []
}
variable "create_nat_gateway_eip" {
  description = "Create Elastic IP for NAT Gatway"
  default = 1
}
variable "multi_az_resource" {
  description = "Multi AZ Resource to decide number of NAT Gateway per AZ"
  default = 0
}

variable "project_name_prefix" {
  description = "Tag with key 'Name' and value as below variable will be applied to created resource."
  type = "string"
  default = "devops"
}

variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames for VPC"
  default = true
  
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  default = true
}




locals {
  public_subnet_count          = "${length(var.public_subnets)}" //2
  min_nat_gateway_count        = "${var.multi_az_resource * local.public_subnet_count}" //0
  nat_gateway_count            = "${local.min_nat_gateway_count < 1 ? 1 : local.min_nat_gateway_count}" //1
  max_subnet_association_count = "${local.nat_gateway_count * local.public_subnet_count}" //2
  subnet_association_count     = "${local.max_subnet_association_count > local.public_subnet_count ? local.public_subnet_count : local.max_subnet_association_count}"
}


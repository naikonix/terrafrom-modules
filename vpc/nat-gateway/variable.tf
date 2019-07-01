variable "project_name_prefix" {
  description = "Project Name Prefix"
  default = ""
}

variable "common_tags" {
  description = "Common Tags"
  type = "map"
  default = {}
}

variable "public_subnet_ids" {
  type    = "list"
  default = []
  description = "Public Subnet IDs"
}

variable "associate_route_table_ids" {
  type = "list"
  description = "Route Table IDs"
}

variable "nat_gateways_allocation_ids" {
  type = "list"
  description = "NAR Gateway Allocation IDs"
}

variable "nat_gateway_count" {}
variable "subnet_association_count" {}

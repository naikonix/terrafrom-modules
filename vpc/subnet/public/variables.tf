variable "project_name_prefix" {}

variable "common_tags" {
  type = "map"
}

variable "vpc_id" {}

variable "public_subnets" {
  type = "list"
}

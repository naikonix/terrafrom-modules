variable "project_name_prefix" {
  default = "Project Name Prefix for Tagging"

}

variable "common_tags" {
  type = "map"
  description = "MAP for Resource Tagging"
}

variable "vpc_id" {
  default = ""
  description = "VPC ID"
}

variable "private_subnets" {
  type = "list"
  description = "Private Subnet List of map with respective AZ and CIDR"
}


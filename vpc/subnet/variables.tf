variable "project_name_prefix" {
  default = ""
  description = "Project Name Prefix for Tagging"
}

variable "common_tags" {
  type = "map"
  description = "Map for Tagging Resources"
  default = {}
}

variable "vpc_cidr" {
  default = ""
  description = "VPC CIDR"
}

variable "public_subnets" {
  type = "list"
  description = "Public Subnet List of map with respective AZ and CIDR"
  default = ""
}

variable "app_private_subnets" {
  description = "Private Subnet List of map with respective AZ and CIDR"
  type = "list"
  default = []
}

variable "db_private_subnets" {
  description = "Private DB Subnet List of map with respective AZ and CIDR"
  type = "list"
  default = []
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames for VPC"
  default = true
  
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  default = true
}
########################### ECS Config ################################

variable "cluster_name" {
  default = ""
}

variable "environment" {
  default = ""
}
variable "servicetype" {
  default = ""
}

variable "ecs_instance_role_name" {
  description = "Role to be attached on Instance to access ECS"
  default = "ecs-instance-role"
}

variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}


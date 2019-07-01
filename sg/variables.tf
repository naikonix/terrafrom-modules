variable "environment" {}
variable "servicetype" {}

variable "vpc_id" {
  default = ""
}

variable "key" {}
variable "rules_egress" {
  type = "map"
  default = {
   "-1:0:0" = "0.0.0.0/0"
  }
}
variable "rules_endpoint" {
  type = "map"
  default = { }
}
variable "rules_sg" {
  type = "map"
  default = { }
}
variable "rules_self" {
  type = "list"
  default = []
}
variable "rules_ingress" {
  type = "map"
  default = { }
}

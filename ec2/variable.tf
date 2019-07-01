variable "ami" {
    description = "AMI ID for Instance"
}

variable "instance_type" {
    description = "AWS EC2 Instance Type"
}

variable "subnet_id" {
    description = "Subnet ID, where to launch EC2 Instance"
}

variable "vpc_security_group_ids" {
    description = "Security Group to be attached with instance"
}

variable "key_name" {
    description = "Key Pair for EC2 Instane"
}


variable "volume_size" {
    description = "Volume Size in GB"
}

variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}

variable "instance_name" {
    description = "Instance Name"
}

variable "source_dest_check" {
    description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
    default = true
}

# Variable defined for Autoscaling Alarm ConfigurationS
variable "autoscaling_alarms_configs" {
  default = {
      period = 60
      evaluation_periods = 2
      threshold_max = 80
      threshold_min = 60
      metric_name = "CPUUtilization"
  }
}
# Variable defined for Autoscaling Configurations
variable "autoscaling_configs" {
  default = {
      max_size = 5
      min_size = 2
      on_demand_base_capacity = 0
      spot_instance_pools = 1
      health_check_grace_period = 300
      on_demand_percentage_above_base_capacity = 10
      ondemandcapacity = 1
  }
}

# Variable Defined for Autoscaling Instance Override
variable "autoscaling_instances" {
  default = {
      supported_instance_1 = "t3.medium"
      supported_instance_2 = "t2.medium"
      supported_instance_3 = "t3.large"
  }
}
# Variable defined for Launch Template Config
variable "launch_template_configs" {
  default = {
      instance_type           = ""
      keyname                 = ""
  } 
}

# Variable defined for Launch Template Block Devices
variable "launch_template_block_device_mapping" {
    default = [
        {
        device_name = "/dev/xvda"
        device_type = "gp2"
        device_size =  50
        },
        {
        device_name = "/dev/sdb"
        device_type = "gp2"
        device_size =  50
        }
    ]
}

# Workstation IP to be added to the minion Security Groups
variable "workstation_ip" {
  
}
# Subnet ID for EKS provisioning
variable "subnet_id" {
}

# AWS login profile
variable "profile" {
  default = "default"
}

# Variable to define in private access to EKS cluster is allowed
variable "endpoint_private_access" {
  default = true
}
# Variable to define in public access to EKS cluster is allowed
variable "endpoint_public_access" {
  default = false
}
# AWS region to provision EKS
variable "aws_region" {
  default = "eu-west-1"  
}

# Roles to be assigned in variables
variable "role" {
  default = "app_k8s"
}
# Project name
variable "project" {
  
}
# EKS environment
variable "environment" {
  
}
# VpcID to provision EKS on
variable "vpcId" {}

# IAM role for worker/minion nodes
variable "minion-role-name" {
  default = "k8s-minion-role"
}

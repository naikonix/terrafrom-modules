/*
# Sample Attributes
project = "upsnap"
role = "upsnap-role"
endpoint_private_access = true
endpoint_public_access = true
vpcId = "vpc-3a23fa40"
environment = "dev"
autoscaling_configs = {
    max_size = 2
    min_size = 1
    on_demand_base_capacity = 0
    spot_instance_pools = 1
    health_check_grace_period = 300
    on_demand_percentage_above_base_capacity = 10
    ondemandcapacity = 1
}

launch_template_configs = {
  instance_type           = "t3.nano"
  keyname                 = "keypair"
}

subnet_id = ["subnet-04765f12d8c56e676", "subnet-0b397e47e55ed6655"]
workstation_ip = ["150.242.60.191/32"]
aws_region = "us-east-1"
*/
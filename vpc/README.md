## Usage

```
module "create_vpc" {
  source                = "./../modules/vpc/"

  project_name_prefix   = "upsnap-admin-tools"
  vpc_cidr              = "10.82.0.0/16"

  public_subnets        = [{az = "eu-west-1a",cidr = "10.82.1.0/24"},
                          {az = "eu-west-1b",cidr = "10.82.2.0/24"},
                          {az = "eu-west-1c",cidr = "10.82.3.0/24"}]
  app_private_subnets   = [{az = "eu-west-1a",cidr = "10.82.4.0/23"},
                          {az = "eu-west-1b",cidr = "10.82.6.0/23"},
                          {az = "eu-west-1c",cidr = "10.82.8.0/23"}]

  enable_dns_support    = true
  enable_dns_hostnames  = true
  common_tags           = {
          Project="upsnap", 
          Env= "DevOps", 
          CreatedBy = "Terraform" 
        }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app\_private\_subnets | Private Subnet (Non-DB Subnet) List of map with respective AZ and CIDR | list | n/a | yes |
| common\_tags | Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' | map | `<map>` | no |
| create\_nat\_gateway\_eip | Create Elastic IP for NAT Gatway | string | `"1"` | no |
| db\_private\_subnets | Private DB Subnet List of map with respective AZ and CIDR | list | `<list>` | no |
| enable\_dns\_hostnames | Enable DNS Hostnames for VPC | string | `"true"` | no |
| enable\_dns\_support | Enable DNS Support | string | `"true"` | no |
| multi\_az\_resource | Multi AZ Resource to decide number of NAT Gateway per AZ | string | `"0"` | no |
| project\_name\_prefix | Tag with key 'Name' and value as below variable will be applied to created resource. | string | `"devops"` | no |
| public\_subnets | Public Subnet List of map with respective AZ and CIDR | list | n/a | yes |
| vpc\_cidr | CIDR for VPC | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_subnet\_ids | Private Subnet ID |
| nat\_gateways\_allocation\_ids | NAT Gateway Allocation IDs |
| nat\_gateways\_public\_ips | NAT Gateways Public IP |
| public\_subnet\_ids | Public Subnet ID |
| vpc\_id | VPC ID |


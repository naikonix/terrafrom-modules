## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app\_private\_subnets | Public Subnet List of map with respective AZ and CIDR | list | `<list>` | no |
| common\_tags | Map for Tagging Resources | map | `<map>` | no |
| enable\_dns\_hostnames | Enable DNS Hostnames for VPC | string | `"true"` | no |
| enable\_dns\_support | Enable DNS Support | string | `"true"` | no |
| project\_name\_prefix | Project Name Prefix for Tagging | string | `""` | no |
| public\_subnets | Public Subnet List of map with respective AZ and CIDR | list | `""` | no |
| vpc\_cidr | VPC CIDR | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_subnet\_ids | Private Subnet ID |
| private\_route\_table\_ids | Private Route Table IDs |
| public\_subnet\_ids | Public Subnet ID |
| vpc\_id | VPC ID |


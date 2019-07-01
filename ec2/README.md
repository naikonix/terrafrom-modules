## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | AMI ID for Instance | string | n/a | yes |
| common\_tags | Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' | map | `<map>` | no |
| instance\_name | Instance Name | string | n/a | yes |
| instance\_type | AWS EC2 Instance Type | string | n/a | yes |
| key\_name | Key Pair for EC2 Instane | string | n/a | yes |
| source\_dest\_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true. | string | `"true"` | no |
| subnet\_id | Subnet ID, where to launch EC2 Instance | string | n/a | yes |
| volume\_size | Volume Size in GB | string | n/a | yes |
| vpc\_security\_group\_ids | Security Group to be attached with instance | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id |  |
| private\_ip |  |
| public\_ip |  |


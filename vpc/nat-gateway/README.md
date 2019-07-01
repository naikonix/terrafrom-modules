## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| associate\_route\_table\_ids | Route Table IDs | list | n/a | yes |
| common\_tags | Common Tags | map | `<map>` | no |
| nat\_gateway\_count |  | string | n/a | yes |
| nat\_gateways\_allocation\_ids | NAR Gateway Allocation IDs | list | n/a | yes |
| project\_name\_prefix | Project Name Prefix | string | `""` | no |
| public\_subnet\_ids | Public Subnet IDs | list | `<list>` | no |
| subnet\_association\_count |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nat\_gateway\_private\_ip | NAT Gateway Private IP |
| nat\_gateway\_public\_ip | NAT Gateway Public IP |


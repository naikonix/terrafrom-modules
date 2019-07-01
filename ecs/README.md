## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | ECS cluster name | string | `"my_ecs_cluster"` | no |
| common\_tags | Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' | map | `<map>` | no |
| ecs\_instance\_role\_name | Role to be attached on Instance to access ECS | string | `"ecs-instance-role"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_cluster\_id | ECS Cluster ID |
| ecs\_cluster\_name | ECS Cluster ID |
| ecs\_instance\_profile | ECS Instance Profile Name |


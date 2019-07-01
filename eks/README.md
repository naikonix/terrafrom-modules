# terraform-aws-eks

A terraform module to create a managed Kubernetes cluster on AWS EKS.

## Assumptions

* Virtual Private Cloud (VPC) and subnets are already created to put the EKS resources.
* [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl) (>=1.14) and [`aws-iam-authenticator`](https://github.com/kubernetes-sigs/aws-iam-authenticator#4-set-up-kubectl-to-use-authentication-tokens-provided-by-aws-iam-authenticator-for-kubernetes) are installed and on your shell's PATH.
* Workstation from where terraform is being executed should have access to the EKS subnet if public endpoint is selected as false 

## Usage example

Bare minimum configuration required to provision EKS successfully.

```hcl
module "my-cluster" {
    source = "./eks"
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
    keyname                 = "keyname"
    }

    subnet_id = ["subnet-04765f12d8c56e676", "subnet-0b397e47e55ed6655"]
    workstation_ip = ["150.242.60.191/32"]
    aws_region = "us-east-1"
}
```
Variable Blocks that can be used (See below table for default values)
Alarm Configuration Block
```hcl
autoscaling_alarms_configs = {
      period = 60
      evaluation_periods = 2
      threshold_max = 80
      threshold_min = 60
      metric_name = "CPUUtilization"
  }
```

Autoscaling Configuration Block
```hcl
autoscaling_configs = {
      max_size = 5
      min_size = 2
      on_demand_base_capacity = 0
      spot_instance_pools = 1
      health_check_grace_period = 300
      on_demand_percentage_above_base_capacity = 10
      ondemandcapacity = 1
  }
```

Autoscaling Override Instances Block
```hcl
autoscaling_instances = {
    supported_instance_1 = "t3.medium"
    supported_instance_2 = "t2.medium"
    supported_instance_3 = "t3.large"
}
```

Launch Template Configuration Block
```hcl
launch_template_configs = {
    instance_type           = "t3.medium"
    keyname                 = "keyname"
} 
```

Launch Template Block Devices Configuration
```hcl
launch_template_block_device_mapping = [
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

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Required as an identifier to tag and name resources. | string | `"upsnap-platform"` | yes |
| environment | Environment for which EKS is being provisioned. | string | `"dev"` | yes |
| vpcId | vpcID to configure the Security Groups. | string | `` | yes |
| aws_region | AWS region to provision EKS on | string | `"eu-west-1"` | no |
| role | Cluster role e.g. Admin-tools-k8s. | string | `"apps-k8s"` | no |
| endpoint\_public\_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. | bool | `"false"` | no |
| endpoint\_private\_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. | bool | `"true"` | no |
| subnet\_id | Subnets to span EKS to. | list | `""` | yes |
| workstation\_ip | IP of the workstation required to configure SG to grant access to the workstation. | ip | `""` | yes |
| launch\_template\_block\_device\_mapping | Block devices to be used in lauuch configurations. | map | n/a | no |
| launch\_template\_configs | Required to provide keypair and instance type for the cluster minions/nodes. | map | `""` | yes |
| autoscaling\_instances | Override instance types to be used during autoscaling . | map | `""` | no |
| autoscaling\_configs | Configurations related to autoscaling. | map | `""` | no |
| autoscaling\_alarms\_configs | Required to setup alarms for autoscaling. | map | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster-sg-id | SG ID of the Cluster. |
| minion-sg-id | SG ID of the nodes. |
| endpoint | EKS API server endpoint. |
| eks-cluster-name | EKS cluster name. |
| kubeconfig-certificate-authority-data | API Server certificate data. |
| minion-role-arn | The ARN for minion/worker nodes role. |


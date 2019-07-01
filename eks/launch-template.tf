data "aws_ami" "eks-minion" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks-cluster.version}-v*"]
  }
  most_recent = true
  owners      = ["602401143452"]
}

locals {
  minions-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks-cluster.certificate_authority.0.data}' '${aws_eks_cluster.eks-cluster.name}'
USERDATA
}

resource "aws_launch_template" "lt" {
  
  name                    = "${var.project}-${var.environment}_lt"
  image_id                = "${data.aws_ami.eks-minion.id}"
  instance_type           = "${var.launch_template_configs.instance_type}"
  key_name                = "${var.launch_template_configs.keyname}"
  vpc_security_group_ids  = ["${aws_security_group.eks-minion-sg.id}"]
  disable_api_termination = false
  user_data               = "${base64encode(local.minions-userdata)}"

  iam_instance_profile {
    arn = "${module.minion-role.profile-arn}"
  }
  dynamic "block_device_mappings" {
    for_each = var.launch_template_block_device_mapping
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        volume_size = block_device_mappings.value.device_size
        volume_type = block_device_mappings.value.device_type
      }
    }
  }

  tag_specifications {
    resource_type =  "volume"

    tags = "${merge(
    map(
     "Name" ,"${var.project}-${var.environment}_lt",
     "Project", "${var.project}",
     "Role", "${var.role}",
     "Environment","${var.environment}",
     "Terraform" , "true",
     "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name}", "owned"
      )
    )}"
  }
  tag_specifications {
    resource_type =  "instance"

    tags = "${merge(
    map(
     "Name" ,"${var.project}-${var.environment}_lt",
     "Project", "${var.project}",
     "Role", "${var.role}",
     "Environment","${var.environment}",
     "Terraform" , "true",
     "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name}", "owned"
      )
    )}"
  }  
  tags = "${merge(
  map(
    "Name" ,"${var.project}-${var.environment}_lt",
     "Project", "${var.project}",
    "Role", "${var.role}",
    "Environment","${var.environment}",
    "Terraform" , "true",
    "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name}", "owned"
    )
  )}"

  lifecycle {
    ignore_changes = [
      "latest_version",
      "user_data",
      "vpc_security_group_ids",
    ]
  }
}
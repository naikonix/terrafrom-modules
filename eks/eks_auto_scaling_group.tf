# Autoscaling Group definition
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.environment}_${var.project}_asg"
  max_size                  = "${var.autoscaling_configs.max_size}"
  min_size                  = "${var.autoscaling_configs.min_size}"
  health_check_grace_period = "${var.autoscaling_configs.health_check_grace_period}"
  health_check_type         = "EC2" 
  desired_capacity          = "${var.autoscaling_configs.min_size}"
  force_delete              = true
  termination_policies      = ["OldestInstance"]

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = "${var.autoscaling_configs.on_demand_base_capacity}"
      on_demand_percentage_above_base_capacity = "${var.autoscaling_configs.ondemandcapacity}"
      spot_instance_pools                      = "${var.autoscaling_configs.spot_instance_pools}"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.lt.id}"
      }
      override {
        instance_type = "${var.autoscaling_instances.supported_instance_1}"
      }

      override {
        instance_type = "${var.autoscaling_instances.supported_instance_2}"
      }

      override {
        instance_type = "${var.autoscaling_instances.supported_instance_3}"
      }
    }
  }
  vpc_zone_identifier = "${var.subnet_id}"
  enabled_metrics = ["GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  tags = "${concat(
      list(
      map("key", "Name", "value", "${var.environment}_${var.project}_asg", "propagate_at_launch", true),
      map("key", "Role", "value", "${var.role}", "propagate_at_launch", true),
      map("key", "Project", "value", "${var.project}", "propagate_at_launch", true),
      map("key", "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name}", "value", "owned", "propagate_at_launch", true),
      map("key", "Environment", "value", "${var.environment}", "propagate_at_launch", true),
      map("key", "Terraform", "value", "true", "propagate_at_launch", true)
    ))
  }"
  timeouts {
    delete = "5m"
  }
  lifecycle {
    ignore_changes = [
      "launch_template",
      "mixed_instances_policy",
    ]
  }
 
}

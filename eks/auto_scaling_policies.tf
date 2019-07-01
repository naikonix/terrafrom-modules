# Autoscaling policies for minion/nodes in EKS
resource "aws_autoscaling_policy" "scaling-up-policy" {
  name               = "${aws_autoscaling_group.asg.name}_up_scaling_policy"
  scaling_adjustment = 1
  adjustment_type    = "ChangeInCapacity"
  cooldown           = 300

  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}

resource "aws_autoscaling_policy" "scaling-down-policy" {
  name               = "${aws_autoscaling_group.asg.name}_down_scaling_policy"
  scaling_adjustment = -1
  adjustment_type    = "ChangeInCapacity"
  cooldown           = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}
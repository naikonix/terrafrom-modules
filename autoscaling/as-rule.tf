resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = "${var.enable_scaling_policies ? 1 : 0}"
  alarm_name          = "${title("ec2-asg-${var.name}-high-cpu-utilization")}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.scaling_policy_high_cpu_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "${var.scaling_policy_high_cpu_period}"
  statistic           = "Average"
  threshold           = "${var.scaling_policy_high_cpu_threshold}"
  alarm_description   = "This metric monitor ec2 high cpu utilization"
  alarm_actions       = "${aws_autoscaling_policy.cpu_scaling_out.*.arn}"
  dimensions =  {
    AutoScalingGroupName = "${aws_autoscaling_group.this.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  count               = "${var.enable_scaling_policies ? 1 : 0}"
  alarm_name          = "${title("ec2-asg-${var.name}-low-cpu-utilization")}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "${var.scaling_policy_low_cpu_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "${var.scaling_policy_low_cpu_period}"
  statistic           = "Average"
  threshold           = "${var.scaling_policy_low_cpu_threshold}"
  alarm_description   = "This metric monitor ec2 low cpu utilization"
  alarm_actions       = "${aws_autoscaling_policy.cpu_scaling_in.*.arn}"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.this.name}"
  }
}

// Auto Scaling Policy
# TODO:  look at changing to a submodule
resource "aws_autoscaling_policy" "cpu_scaling_out" {
  count                  = "${var.enable_scaling_policies ? 1 : 0}"
  name                   = "cpu-scaling-out"
  scaling_adjustment     = "${length(var.vpc_zone_identifier)}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "${var.scaling_policy_scaling_out_cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.this.name}"
}

resource "aws_autoscaling_policy" "cpu_scaling_in" {
  count                  = "${var.enable_scaling_policies ? 1 : 0}"
  name                   = "cpu-scaling-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "${var.scaling_policy_scaling_in_cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.this.name}"
}

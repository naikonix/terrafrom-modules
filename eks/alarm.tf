
# Autoscaling alarms resources
resource "aws_cloudwatch_metric_alarm" "high-cpu-alarm" {
  
  alarm_name                = "${aws_autoscaling_group.asg.name}_high_cpu_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "${var.autoscaling_alarms_configs.evaluation_periods}"
  metric_name               = "${var.autoscaling_alarms_configs.metric_name}"
  namespace                 = "AWS/EC2"
  period                    = "${var.autoscaling_alarms_configs.period}"
  statistic                 = "Average"
  threshold                 = "${var.autoscaling_alarms_configs.threshold_max}"
  alarm_description         = "High CPU for ${aws_autoscaling_group.asg.name}"
  insufficient_data_actions = []
  alarm_actions = ["${aws_autoscaling_policy.scaling-up-policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "low-cpu-alarm" {
  alarm_name                = "${aws_autoscaling_group.asg.name}_low_cpu_alarm"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "${var.autoscaling_alarms_configs.evaluation_periods}"
  metric_name               = "${var.autoscaling_alarms_configs.metric_name}"
  namespace                 = "AWS/EC2"
  period                    = "${var.autoscaling_alarms_configs.period}"
  statistic                 = "Average"
  threshold                 = "${var.autoscaling_alarms_configs.threshold_min}"
  alarm_description         = "Low CPU for ${aws_autoscaling_group.asg.name}"
  insufficient_data_actions = []
  alarm_actions = ["${aws_autoscaling_policy.scaling-down-policy.arn}"]
}
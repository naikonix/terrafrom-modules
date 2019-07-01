// Service autoscaling
resource "aws_appautoscaling_target" "ecs_target" {
  count              = "${var.enable_service_autoscaling ? 1 : 0}"
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${var.cluster}/${var.name}"
  role_arn           = "${var.iam_role}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = "${var.enable_service_autoscaling ? 1 : 0}"
  alarm_name          = "${title("ecs-asg-${var.name}-high-cpu-utilization")}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.scaling_policy_high_cpu_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.scaling_policy_high_cpu_period}"
  statistic           = "Average"
  threshold           = "${var.scaling_policy_high_cpu_threshold}"
  alarm_description   = "This metric monitor ecs high cpu utilization"
  alarm_actions       = "${aws_appautoscaling_policy.ecs_policy.*.arn}"
  # dimensions =  {
  #   AutoScalingGroupName = "${aws_appautoscaling_target.ecs_target.*.name}"
  # }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  count               = "${var.enable_service_autoscaling ? 1 : 0}"
  alarm_name          = "${title("ecs-asg-${var.name}-low-cpu-utilization")}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "${var.scaling_policy_low_cpu_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.scaling_policy_low_cpu_period}"
  statistic           = "Average"
  threshold           = "${var.scaling_policy_low_cpu_threshold}"
  alarm_description   = "This metric monitor ecs low cpu utilization"
  alarm_actions       = "${aws_appautoscaling_policy.ecs_policy.*.arn}"
  # dimensions = {
  #   AutoScalingGroupName = "${aws_appautoscaling_group.ecs_target.*.name}"
  # }
}
resource "aws_appautoscaling_policy" "ecs_policy" {
  count              = "${var.enable_service_autoscaling ? 1 : 0}"
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster}/${var.name}"
  scalable_dimension = "${join(", ",aws_appautoscaling_target.ecs_target.*.scalable_dimension)}"
  service_namespace  = "${join(", ",aws_appautoscaling_target.ecs_target.*.service_namespace)}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 1.0
      metric_interval_upper_bound = 2.0
      scaling_adjustment          = -1
    }

    step_adjustment {
      metric_interval_lower_bound = 2.0
      scaling_adjustment          = 1
    }
  }
}
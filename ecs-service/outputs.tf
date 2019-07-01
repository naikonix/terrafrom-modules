output "task_role" {
  description = "The task role name used by the task definition"
  value       = "${aws_iam_role.main.name}"
}

output "task_role_arn" {
  description = "The task role arn used by the task definition"
  value       = "${aws_iam_role.main.arn}"
}

// It has proven be useful to be used as input for other modules
output "target_group" {
  description = "The target group name created by this module"
  value       = "${aws_alb_target_group.main.name}"
}

output "target_group_arn_suffix" {
  description = "The target group suffix to use as input on alarms"
  value       = "${aws_alb_target_group.main.arn_suffix}"
}

output "iam_role" {
  value = "${aws_iam_role.main.arn}"
}

// aws ecs autoscaling output

output "scalable_dimension" {
  value = "${aws_appautoscaling_target.ecs_target.*.scalable_dimension}"
}
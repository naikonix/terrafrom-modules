/**
 * Required Variables.
 */

variable "name" {
  description = "The service name"
}

variable "cluster" {
  description = "The cluster name"
}

variable "vpc_id" {
  description = "The VPC ID were the ECS is running"
}

// ECS autoscaling
variable "enable_service_autoscaling" {
  description = "Enable ecs service autoscaling"
  default     = false
}

variable "scalable_dimension" {
  default = ""
}

# variable "service_namespace" {
#   default = ""
# }


variable "container_definitions" {
  description = "here you should include the full container definitions"
}

variable "iam_role" {
  description = "IAM Role ARN to use"
}

variable "listener_arn" {
  description = "Listener where the rule will be added"
}

variable "alb_dns_name" {
  description = "DNS name of the ALB where the rule will be added"
}

variable "zone_id" {
  
}


variable "alb_zone_id" {
  description = "Zone ID where the ALB is hosted"
}

variable "rule_priority" {
  description = "This is the priority number of the listener's rule"
}

/**
 * Optional Variables.
 */

variable "environment" {
  description = "Environment tag, e.g prod"
  default     = "default"
}

variable "container_port" {
  description = "The container port"
  default     = 80
}

variable "healthcheck" {
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    path                = "/health"
    interval            = 30
    matcher             = 200
  }
}

variable "desired_count" {
  description = "The desired count"
  default     = 1
}

variable "policy" {
  description = "IAM custom policy to be attached to the task role"
  default     = ""
}

variable "cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target.The range is 1 second to 1 week (604800 seconds)"
  default     = "86400"
}

variable "stick_enabled" {
  description = "Boolen to enable / disable stickiness"
  default     = "false"
}

variable "enable_route_53" {
  description = "Enable route 53"
}


// ecs cloudwatch alarm
variable "scaling_policy_high_cpu_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 5
}

variable "scaling_policy_high_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied"
  default     = 60
}

variable "scaling_policy_high_cpu_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 60
}

variable "scaling_policy_low_cpu_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 3
}

variable "scaling_policy_low_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied"
  default     = 900
}

variable "scaling_policy_low_cpu_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 0
}
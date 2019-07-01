variable "name" {
  description = "Base name for resource"
  type        = "string"
}

variable "tags" {
  description = "A map of additional tags"
  type = "list"
  default     = []
}
variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = "map"
  default     = {}
}

// Variables specific to this module
variable "create_lc" {
  description = "Set to false to prevent the module from creating Launch Configuration"
  default     = true
}

// Launch configuration variables

variable "image_id" {
  description = "The EC2 image ID to launch"
}

variable "instance_type" {
  description = "The size of instance to launch"
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  default     = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  default     = ""
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  type        = "list"
  default     = []
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  default     = false
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = " "
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  default     = false
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = "list"
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = "list"
  default     = []
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = "list"
  default     = []
}

// Autoscaling group variables
variable "asg_name" {
  description = "Override autoscaling group prefix name"
  default     = ""
}

variable "launch_configuration" {
  description = "The name of the launch configuration to use (if it is created outside of this module)"
  default     = ""
}

variable "max_size" {
  description = "The maximum size of the auto scale group"
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
}

variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  default     = []
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = "list"
  default     = ["OldestLaunchConfiguration", "Default"]
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = "list"

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 0
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = "list"
}

// Autoscaling rules
variable "enable_scaling_policies" {
  description = "Enable default scale-in and scale-out policies based on CPU Utilization"
  default     = false
}

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

variable "scaling_policy_scaling_out_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
  default     = 300
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

variable "scaling_policy_scaling_in_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
  default     = 3000
}
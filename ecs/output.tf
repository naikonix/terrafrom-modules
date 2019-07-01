output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value = "${aws_ecs_cluster.this.id}"
}

output "ecs_cluster_name" {
  description = "ECS Cluster ID"
  value = "${aws_ecs_cluster.this.name}"
}

output "ecs_instance_profile" {
  description = "ECS Instance Profile Name"
  value = "${aws_iam_instance_profile.ecs-instance-profile.name}"
}

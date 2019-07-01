output "role-name" {
  value = "${aws_iam_role.ec2-role.name}"
}

output "role-arn" {
  value = "${aws_iam_role.ec2-role.arn}"
}
output "profile-arn" {
  value = "${aws_iam_instance_profile.ec2-instance-profile.arn}"
}
output "profile-name" {
  value = "${aws_iam_instance_profile.ec2-instance-profile.name}"
}

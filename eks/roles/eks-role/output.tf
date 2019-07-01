output "role-name" {
  value = "${aws_iam_role.eks-role.name}"
}

output "role-arn" {
  value = "${aws_iam_role.eks-role.arn}"
}

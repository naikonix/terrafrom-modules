resource "aws_iam_role_policy_attachment" "ec2-policy-attachment" {
  role       = "${var.role}"
  policy_arn = "${var.policy_arn}"
}

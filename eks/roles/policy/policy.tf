resource "aws_iam_policy" "policy" {
  name        = "${var.policy_name}"
  path        = "/"
  description = "${var.description}"
  policy = "${var.policy_doc}"
}


data "aws_iam_policy_document" "ec2-instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ec2-role" {
  name               = "${var.environment}-${var.role-name}"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-instance-assume-role-policy.json}"
  path               = "/"
  description        = "For granting acess to ec2 instances to access resources on your behalf"
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "${aws_iam_role.ec2-role.name}"
  role = "${aws_iam_role.ec2-role.name}"
}
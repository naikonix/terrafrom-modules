data "aws_iam_policy_document" "eks-cluster-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-role" {
  name               = "${var.environment}-eksServiceRole"
  assume_role_policy = "${data.aws_iam_policy_document.eks-cluster-assume-role-policy.json}"
  path               = "/"
  description        = "For granting acess to eks cluster to manage resources on your behalf"
}

resource "aws_iam_instance_profile" "eks-instance-profile" {
  name = "${aws_iam_role.eks-role.name}"
  role = "${aws_iam_role.eks-role.name}"
}

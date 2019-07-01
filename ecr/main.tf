resource "aws_ecr_repository" "ecr" {
  name = "${var.ecr_project_name}"
}
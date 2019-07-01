output "ecr_repository_url" {
  description = "ECR Repository URL"
  value = "${aws_ecr_repository.ecr.repository_url}"
}

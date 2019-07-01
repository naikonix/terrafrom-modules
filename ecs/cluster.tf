resource "aws_ecs_cluster" "this" {
  name = "${var.cluster_name}"
  tags = "${merge(
    "${var.common_tags}",
    map(
     "Name" ,"${format("%s-%s", lower(var.environment), lower(var.servicetype))}"
      )
  )}"
}
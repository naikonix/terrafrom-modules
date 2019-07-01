
# EKS resource definition
resource "aws_eks_cluster" "eks-cluster" {
  enabled_cluster_log_types = ["api", "scheduler"]
  name                      = "${var.project}_${var.environment}_eks_cluster"
  role_arn                  = "${module.cluster-role.role-arn}"
  
  vpc_config {
    subnet_ids = "${var.subnet_id}"
    endpoint_private_access = "${var.endpoint_private_access}"
    endpoint_public_access = "${var.endpoint_public_access}"
    security_group_ids = ["${aws_security_group.eks-cluster-sg.id}"]
  }
}




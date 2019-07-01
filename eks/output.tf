output "cluster-sg-id" {
  value = "${aws_security_group.eks-cluster-sg.id}"
}
output "minion-sg-id" {
  value = "${aws_security_group.eks-minion-sg.id}"
}
output "kong-alb-sg-id" {
  value = "${aws_security_group.kong-alb-sg.id}"
}
output "endpoint" {
  value = "${aws_eks_cluster.eks-cluster.endpoint}"
}
output "eks-cluster-name" {
  value = "${aws_eks_cluster.eks-cluster.id}"
}
output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}"
}
output "minion-role-arn" {
  value = "${module.minion-role.role-arn}"
}

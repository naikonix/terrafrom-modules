# Security Groups definition for EKS minion/nodes.

resource "aws_security_group" "eks-minion-sg" {
  name   = "${var.environment}_minion_sg"
  vpc_id = "${var.vpcId}"
  description = "EKS minion security group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow minions to communicate to outside world"
  }

    tags = "${merge(
    map(
     "Name" ,"${var.environment}_eks_minion_sg",
     "Project", "${var.project}",
     "Role", "${var.role}",
     "Environment","${var.environment}",
     "Terraform" , "true",
     "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}", "owned"
      )
  )}"
}
resource "aws_security_group_rule" "eks-minion-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.eks-minion-sg.id}"
  source_security_group_id = "${aws_security_group.eks-minion-sg.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-minion-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-minion-sg.id}"
  source_security_group_id = "${aws_security_group.eks-cluster-sg.id}"
  to_port                  = 65535
  type                     = "ingress"
}

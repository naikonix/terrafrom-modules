# Security Groups for EKS master
resource "aws_security_group" "eks-cluster-sg" {
  name   = "${var.environment}_eks_cluster_sg"
  vpc_id = "${var.vpcId}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    map(
     "Name" ,"${var.environment}_cluster_sg",
     "Project", "${var.project}",
     "Role", "${var.role}",
     "Environment","${var.environment}",
     "Terraform" , "true",
      )
  )}"
}
/*
resource "aws_security_group_rule" "eks-cluster-ingress-minion-https" {
  
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-cluster-sg.id}"
  source_security_group_id = "${aws_security_group.eks-workstation-sg.id}"
  to_port           = 443
  type              = "ingress"
}
*/
resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-cluster-sg.id}"
  source_security_group_id = "${aws_security_group.eks-minion-sg.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-cluster-sg.id}"
  cidr_blocks              = "${var.workstation_ip}"
  to_port                  = 443
  type                     = "ingress"
}
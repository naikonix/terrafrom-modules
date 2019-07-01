# Security Groups required by the kong ingress controller
resource "aws_security_group" "kong-alb-sg" {
  name   = "${var.environment}_kong_alb_sg"
  vpc_id = "${var.vpcId}"
  description = "kong alb non production security group"

    tags = "${merge(
    map(
     "Name" ,"${var.environment}_minion_sg",
     "Project", "${var.project}",
     "Role", "${var.role}",
     "Environment","${var.environment}",
     "Terraform" , "true",
     "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}", "owned"
      )
  )}"
}
resource "aws_security_group_rule" "kong-https-allow" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow access from world"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.kong-alb-sg.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "kong-allow-alb-minion" {

  description       = "Allow communication from kong loadbalancer to minions"
  from_port         = 0
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-minion-sg.id}"
  source_security_group_id = "${aws_security_group.kong-alb-sg.id}"
  to_port           = 65535
  type              = "ingress"
}

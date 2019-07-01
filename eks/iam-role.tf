# Roles required by the workers and master to effectively manage the resource required
# for functioning of the cluster
# Depends on roles module
data "template_file" "ingress-policy" {
  template = "${file("${path.module}/iam-policy/alb-ingress-controller-policy.json.tpl")}"
}
data "template_file" "CA-policy" {
  template = "${file("${path.module}/iam-policy/cluster-autoscaler-policy.json.tpl")}"
}

module "minion-alb-ingress-policy" {
  source = "./roles/policy"
  policy_name = "${var.environment}-alb-ingress-controller-policy"
  description = "used for alb ingress controller access"
policy_doc= "${data.template_file.ingress-policy.rendered}"
}
module "minion-alb-CA-policy" {
  source = "./roles/policy"
  policy_name = "${var.environment}-cluster-autoscaler-policy"
  description = "used for cluster autoscaler access"
policy_doc= "${data.template_file.CA-policy.rendered}"
}

module "cluster-role" {
    source = "./roles/eks-role/"
    environment = "${var.environment}"    
}
module "minion-role" {
 source = "./roles/ec2-role/"
 environment = "${var.environment}"
 role-name = "${var.minion-role-name}"    
}

module "attachment-cluster-policy" {
   source = "./roles/attachment/"
   role= "${module.cluster-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

module "attachment-cluster-service-policy" {
   source = "./roles/attachment/"
   role= "${module.cluster-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

module "attachment-minion-ingress-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "${module.minion-alb-ingress-policy.policy-arn}"
}

module "attachment-minion-CA-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "${module.minion-alb-CA-policy.policy-arn}"
}

module "attachment-minion-worker-node-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

module "attachment-minion-container-registry-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

module "attachment-minion-CNI-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

module "attachment-minion-s3-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"  
   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

module "attachment-minion-ssm-policy" {
   source = "./roles/attachment/"
   role= "${module.minion-role.role-name}"
   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

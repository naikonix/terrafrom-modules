# Resource to create the kubeconfig file to interact with the cluster effecively
locals {
  aws_auth_configmap = <<AWS_AUTH
- rolearn: ${module.minion-role.role-arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
AWS_AUTH
}
resource "local_file" "kube-config-yaml" {
  content = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.eks-cluster.id}"
KUBECONFIG
filename = "${path.module}/.kube/config"
}

provider "kubernetes" {
  config_path = "${local_file.kube-config-yaml.filename}"
}
# The following configmap is required to get the minion registered with the cluster
resource "kubernetes_config_map" "aws-auth" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = "${local.aws_auth_configmap}"
  }
}

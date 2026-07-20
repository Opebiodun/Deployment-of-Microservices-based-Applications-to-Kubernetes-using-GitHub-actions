terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

data "aws_eks_cluster" "micro-dev-eks-demo" {
  name = "micro-dev-eks-demo"
}

data "aws_eks_cluster_auth" "micro-dev-eks-demo" {
  name = "micro-dev-eks-demo"
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.micro-dev-eks-demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.micro-dev-eks-demo.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.micro-dev-eks-demo.token
}



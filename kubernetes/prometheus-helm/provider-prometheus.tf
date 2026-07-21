terraform {
  backend "s3" {}
  

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    kubernetes = {
        version = ">= 2.0.0"
        source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
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

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.micro-dev-eks-demo.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.micro-dev-eks-demo.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.micro-dev-eks-demo.token
  }
}


provider "aws" {
  region=$AWS_REGION
  input=false
}

#export the kubeconfig file

#export KUBECONFIG=~/.kube/config
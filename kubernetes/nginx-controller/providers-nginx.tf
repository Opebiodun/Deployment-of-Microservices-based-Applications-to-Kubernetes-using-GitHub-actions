terraform {
  provider "helm" {
  kubernetes {
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


provider "aws" {
  region     = "eu-west-2"
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.micro-dev-eks-demo.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.micro-dev-eks-demo.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.micro-dev-eks-demo.token
  }
}
#export the kubeconfig file

#export KUBECONFIG=~/.kube/config
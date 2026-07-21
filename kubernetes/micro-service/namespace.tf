#resource "kubernetes_namespace" "kube-namespace" {
  metadata {
    name = "sock-shop"
  }
}
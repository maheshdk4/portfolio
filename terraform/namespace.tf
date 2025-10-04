resource "kubernetes_namespace" "portfolio" {
  metadata {
    name = "portfolio"
    labels = {
      name = "portfolio"
    }
  }
}
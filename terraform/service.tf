resource "kubernetes_service" "portfolio" {
  metadata {
    name      = "portfolio-service"
    namespace = kubernetes_namespace.portfolio.metadata[0].name
    labels = {
      app = "portfolio"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    selector = {
      app = "portfolio"
    }
  }
}
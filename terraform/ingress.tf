resource "kubernetes_ingress_v1" "portfolio" {
  metadata {
    name      = "portfolio-ingress"
    namespace = kubernetes_namespace.portfolio.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target"     = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "cert-manager.io/cluster-issuer"                 = "letsencrypt-prod"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = [var.domain_name]
      secret_name = "portfolio-tls"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.portfolio.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
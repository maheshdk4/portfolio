resource "kubernetes_deployment" "portfolio" {
  metadata {
    name      = "portfolio-app"
    namespace = kubernetes_namespace.portfolio.metadata[0].name
    labels = {
      app = "portfolio"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "portfolio"
      }
    }

    template {
      metadata {
        labels = {
          app = "portfolio"
        }
      }

      spec {
        security_context {
          run_as_non_root = true
          run_as_user     = 101
          fs_group        = 101
        }

        container {
          name              = "portfolio"
          image             = "maheshdk4/portfolio:${var.image_tag}"
          image_pull_policy = "Always"

          port {
            container_port = 80
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            capabilities {
              drop = ["ALL"]
            }
          }

          resources {
            requests = {
              memory = "64Mi"
              cpu    = "50m"
            }
            limits = {
              memory = "128Mi"
              cpu    = "100m"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}
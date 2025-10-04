resource "kubernetes_network_policy" "portfolio" {
  metadata {
    name      = "portfolio-netpol"
    namespace = kubernetes_namespace.portfolio.metadata[0].name
  }

  spec {
    pod_selector {
      match_labels = {
        app = "portfolio"
      }
    }

    policy_types = ["Ingress", "Egress"]

    ingress {
      from {
        namespace_selector {
          match_labels = {
            name = "ingress-nginx"
          }
        }
      }
      ports {
        port     = "80"
        protocol = "TCP"
      }
    }

    egress {
      to {}
      ports {
        port     = "53"
        protocol = "TCP"
      }
      ports {
        port     = "53"
        protocol = "UDP"
      }
    }
  }
}
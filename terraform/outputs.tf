output "namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace.portfolio.metadata[0].name
}

output "service_name" {
  description = "Kubernetes service name"
  value       = kubernetes_service.portfolio.metadata[0].name
}

output "deployment_name" {
  description = "Kubernetes deployment name"
  value       = kubernetes_deployment.portfolio.metadata[0].name
}

output "ingress_host" {
  description = "Ingress hostname"
  value       = var.domain_name
}
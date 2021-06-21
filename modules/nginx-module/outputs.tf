# Output variable definitions

output "name" {
  description = "Name of the deployment."
  value       = kubernetes_deployment.nginx.metadata.0.name
}

output "id" {
  description = "he unique in time and space value for this deployment."
  value       = kubernetes_deployment.nginx.id
}

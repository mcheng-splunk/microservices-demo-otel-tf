# Output variable definitions

output "name" {
  description = "Name of the deployment."
  #value       = kubernetes_deployment.checkoutservice.metadata.0.name
  value = kubernetes_deployment.checkoutservice.spec[0].template[0].spec[0].container[0].name
}

output "id" {
  description = "The unique in time and space value for this deployment."
  value       = kubernetes_deployment.checkoutservice.id
}


output "ip-address" {
  description = "Internal Ip address of the server."
  value       = kubernetes_service.checkoutservice.spec[0].cluster_ip
}


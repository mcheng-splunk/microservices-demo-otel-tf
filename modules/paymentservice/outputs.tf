# Output variable definitions

output "name" {
  description = "Name of the deployment."
  #value       = kubernetes_deployment.paymentservice.metadata.0.name
  value = kubernetes_deployment.paymentservice.spec[0].template[0].spec[0].container[0].name
}

output "id" {
  description = "The unique in time and space value for this deployment."
  value       = kubernetes_deployment.paymentservice.id
}


output "ip-address" {
  description = "Internal Ip address of the server."
  value       = kubernetes_service.paymentservice.spec[0].cluster_ip
}
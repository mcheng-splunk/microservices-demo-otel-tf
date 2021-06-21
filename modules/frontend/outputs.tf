# Output variable definitions

output "name" {
  description = "Name of the deployment."
  #value       = kubernetes_deployment.frontend.metadata.0.name
  value = kubernetes_deployment.frontend.spec[0].template[0].spec[0].container[0].name
}

output "id" {
  description = "The unique in time and space value for this deployment."
  value       = kubernetes_deployment.frontend.id
}


output "ip-address" {
  description = "Internal Ip address of the server."
  value       = kubernetes_service.frontend.spec[0].cluster_ip
}

output "RUM_REALM" {
  description = "RUM Realm value."
  value       = var.RUM_ENABLED ? kubernetes_deployment.frontend.spec[0].template[0].spec[0].container[0].env[1].value : null
}


output "AD_SERVICE_ADDR" {
  description = "AD_SERVICE_ADDR value."
  value       = kubernetes_deployment.frontend.spec[0].template[0].spec[0].container[0].env[11].value
}
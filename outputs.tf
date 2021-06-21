# Output definitions


# ************ Nginx configuration ************

# output "nginx-name" {
#   description = "Name of the deployment."
#   value       = module.nginx.name
# }

# output "nginx-id" {
#   description = "he unique in time and space value for this deployment."
#   value       = module.nginx.id
# }

# ************ Redis cart configuration ************

output "redis-cart-name" {
  description = "Name of the deployment."
  value       = module.redis-cart.name
}


output "redis-cart-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.redis-cart.id
}


output "redis-cart-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.redis-cart.ip-address
}

# ************ Shipping Service configuration ************

output "shippingservice-name" {
  description = "Name of the deployment."
  value       = module.shippingservice.name
}


output "shippingservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.shippingservice.id
}


output "shippingservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.shippingservice.ip-address
}


# ************ Recommendation Service configuration ************

output "recommendationservice-name" {
  description = "Name of the deployment."
  value       = module.recommendationservice.name
}


output "recommendationservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.recommendationservice.id
}


output "recommendationservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.recommendationservice.ip-address
}


# ************ Product Catalog Service configuration ************

output "productcatalogservice-name" {
  description = "Name of the deployment."
  value       = module.productcatalogservice.name
}


output "productcatalogservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.productcatalogservice.id
}


output "productcatalogservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.productcatalogservice.ip-address
}


# ************ Payent Service configuration ************

output "paymentservice-name" {
  description = "Name of the deployment."
  value       = module.paymentservice.name
}


output "paymentservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.paymentservice.id
}


output "paymentservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.paymentservice.ip-address
}


# ************ Load Generator configuration ************

output "loadgenerator-name" {
  description = "Name of the deployment."
  value       = module.loadgenerator.name
}


output "loadgenerator-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.loadgenerator.id
}


output "loadgenerator-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.loadgenerator.ip-address
}


# ************ Frontend configuration ************

output "frontend-name" {
  description = "Name of the deployment."
  value       = module.frontend.name
}


output "frontend-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.frontend.id
}


output "frontend-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.frontend.ip-address
}

output "frontend-pod-RUM_REALM" {
  description = "RUM_REALM value."
  value       = module.frontend.RUM_REALM
}

output "frontend-pod-AD_SERVICE_ADDR" {
  description = "AD_SERVICE_ADDR value."
  value       = module.frontend.AD_SERVICE_ADDR
}

# ************ Email Service configuration ************

output "emailservice-name" {
  description = "Name of the deployment."
  value       = module.emailservice.name
}


output "emailservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.emailservice.id
}


output "emailservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.emailservice.ip-address
}

# ************ Currency Service configuration ************

output "currencyservice-name" {
  description = "Name of the deployment."
  value       = module.currencyservice.name
}


output "currencyservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.currencyservice.id
}


output "currencyservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.currencyservice.ip-address
}


# ************ Checkout Service configuration ************

output "checkoutservice-name" {
  description = "Name of the deployment."
  value       = module.checkoutservice.name
}


output "checkoutservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.checkoutservice.id
}


output "checkoutservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.checkoutservice.ip-address
}


# ************ Cart Service configuration ************

output "cartservice-name" {
  description = "Name of the deployment."
  value       = module.cartservice.name
}


output "cartservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.cartservice.id
}


output "cartservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.cartservice.ip-address
}

# ************ ad Service configuration ************

output "adservice-name" {
  description = "Name of the deployment."
  value       = module.adservice.name
}


output "adservice-id" {
  description = "The unique in time and space value for this deployment."
  value       = module.adservice.id
}


output "adservice-pod-ip-address" {
  description = "Internal Ip address of the server."
  value       = module.adservice.ip-address
}


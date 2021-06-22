# module "nginx" {
#   source = "./modules/nginx-module"
# }

module "redis-cart" {
  source = "./modules/redis-cart"
}

module "shippingservice" {
  source = "./modules/shippingservice"
}

module "recommendationservice" {
  source = "./modules/recommendationservice"
}

module "productcatalogservice" {
  source = "./modules/productcatalogservice"
}

module "paymentservice" {
  source = "./modules/paymentservice"
}

module "loadgenerator" {
  source = "./modules/loadgenerator"
}

module "frontend" {
  source = "./modules/frontend"

  ## RUM Fields - If the RUM_ENABLED @ terraform.tfvars is set to "true", the RUM_<VARIABLES> must be set according.
  RUM_ENABLED = var.RUM_ENABLED
  RUM_REALM = var.RUM_REALM
  RUM_AUTH = var.RUM_AUTH
  RUM_APP_NAME = var.RUM_APP_NAME
  RUM_ENVIRONMENT = var.RUM_ENVIRONMENT
}

module "emailservice" {
  source = "./modules/emailservice"
}

module "otel" {
  source = "./modules/otel"
  SPLUNKREALM = var.SPLUNKREALM
    
  SPLUNKACCESSTOKEN = var.SPLUNKACCESSTOKEN
    
  CLUSTERNAME = var.CLUSTERNAME
}


module "currencyservice" {
  source = "./modules/currencyservice"
}


module "checkoutservice" {
  source = "./modules/checkoutservice"
}


module "cartservice" {
  source = "./modules/cartservice"
}


module "adservice" {
  source = "./modules/adservice"
}
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

  # RUM Fields - If the RUM_ENABLED is set to "true", the RUM_<VARIABLES> must be set according.
  # RUM_ENABLED = "false"
  # RUM_REALM = "us0"
  # RUM_AUTH" = null
  # RUM_APP_NAME" = null
  # RUM_ENVIRONMENT" = null
}

module "emailservice" {
  source = "./modules/emailservice"
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
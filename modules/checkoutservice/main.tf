resource "kubernetes_deployment" "checkoutservice" {
  metadata {
    name = "checkoutservice"
    labels = {
      app = "checkoutservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "checkoutservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "checkoutservice"
        }
      }
      spec {
        container {
          image = "quay.io/signalfuse/microservices-demo-checkoutservice:latest"
          name  = "server"

          port {
            container_port = 5050
          }

          env {
            name = "NODE_IP"
            value_from {
              field_ref {
                field_path = "status.podIP"
              }
            }
          }

          env {
            name  = "SIGNALFX_ENDPOINT_URL"
            value = "http://$(NODE_IP):9411/api/v2/spans"
          }

          env {
            name  = "MAX_RETRY_ATTEMPTS"
            value = "20"
          }

          env {
            name  = "RETRY_INITIAL_SLEEP_MILLIS"
            value = "25"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
          }
          env {
            name  = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051"
          }
          env {
            name  = "PAYMENT_SERVICE_ADDR"
            value = "paymentservice:50051"
          }
          env {
            name  = "EMAIL_SERVICE_ADDR"
            value = "emailservice:5000"
          }
          env {
            name  = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000"
          }
          env {
            name  = "CART_SERVICE_ADDR"
            value = "cartservice:7070"
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "128Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "64Mi"
            }
          }
          liveness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:5050"]
            }
          }
          readiness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:5050"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "checkoutservice" {
  metadata {
    name = "checkoutservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.checkoutservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 5050
      target_port = 5050
    }

    type = "ClusterIP"
  }
}
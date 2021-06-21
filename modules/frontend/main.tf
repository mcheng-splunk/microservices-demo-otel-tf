resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      app = "frontend"
    }
    annotations = {
      "sidecar.istio.io/rewriteAppHTTPProbers" = "true"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        container {
          image = "quay.io/signalfuse/microservices-demo-frontend:latest"
          name  = "server"

          port {
            container_port = 8080
          }

          env {
            name  = "RUM_DEBUG"
            value = var.RUM_ENABLED ? var.RUM_DEBUG : null
          }

          env {
            name  = "RUM_REALM"
            value = var.RUM_ENABLED ? var.RUM_REALM : null
          }

          env {
            name  = "RUM_AUTH"
            value = var.RUM_ENABLED ? var.RUM_AUTH : null
          }

          env {
            name  = "RUM_APP_NAME"
            value = var.RUM_ENABLED ? var.RUM_APP_NAME : null
          }

          env {
            name  = "RUM_ENVIRONMENT"
            value = var.RUM_ENABLED ? var.RUM_ENVIRONMENT : null
          }

          env {
            name  = "ENV_PLATFORM"
            value = "gcp"
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
            name  = "SIGNALFX_SERVER_TIMING_CONTEXT"
            value = "true"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
          }
          env {
            name  = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000"
          }
          env {
            name  = "CART_SERVICE_ADDR"
            value = "cartservice:7070"
          }
          env {
            name  = "RECOMMENDATION_SERVICE_ADDR"
            value = "recommendationservice:8080"
          }
          env {
            name  = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051"
          }
          env {
            name  = "CHECKOUT_SERVICE_ADDR"
            value = "checkoutservice:5050"
          }
          env {
            name  = "AD_SERVICE_ADDR"
            value = "adservice:9555"
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
            initial_delay_seconds = 10
            http_get {
              path = "/_healthz"
              port = 8080
              http_header {
                name  = "Cookie"
                value = "shop_session-id=x-readiness-probe"
              }
            }
          }
          readiness_probe {
            initial_delay_seconds = 10
            http_get {
              path = "/_healthz"
              port = 8080
              http_header {
                name  = "Cookie"
                value = "shop_session-id=x-readiness-probe"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    selector = {
      app = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "frontend-external" {
  metadata {
    name = "frontend-external"
  }
  spec {
    selector = {
      app = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
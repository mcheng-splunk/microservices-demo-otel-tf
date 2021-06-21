resource "kubernetes_deployment" "recommendationservice" {
  metadata {
    name = "recommendationservice"
    labels = {
      app = "recommendationservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "recommendationservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "recommendationservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        container {
          image = "quay.io/signalfuse/microservices-demo-recommendationservice:latest"
          name  = "recommendationservice"

          port {
            container_port = 8080
          }
          env {
            name  = "PORT"
            value = "8080"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
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

          resources {
            limits = {
              cpu    = "200m"
              memory = "450Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "220Mi"
            }
          }
          liveness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:8080"]
            }
          }
          readiness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:8080"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "recommendationservice" {
  metadata {
    name = "recommendationservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.recommendationservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


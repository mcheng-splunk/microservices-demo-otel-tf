resource "kubernetes_deployment" "shippingservice" {
  metadata {
    name = "shippingservice"
    labels = {
      app = "shippingservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "shippingservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "shippingservice"
        }
      }
      spec {
        container {
          image = "quay.io/signalfuse/microservices-demo-shippingservice:latest"
          name  = "shippingservice"

          port {
            container_port = 50051
          }
          env {
            name  = "PORT"
            value = "50051"
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
              memory = "128Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "64Mi"
            }
          }
          liveness_probe {
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:50051"]
            }
          }
          readiness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:50051"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shippingservice" {
  metadata {
    name = "shippingservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.shippingservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 50051
      target_port = 50051
    }

    type = "ClusterIP"
  }
}


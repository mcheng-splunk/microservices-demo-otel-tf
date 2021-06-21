resource "kubernetes_deployment" "paymentservice" {
  metadata {
    name = "paymentservice"
    labels = {
      app = "paymentservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "paymentservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "paymentservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        container {
          image = "quay.io/signalfuse/microservices-demo-paymentservice:latest"
          name  = "paymentservice"

          port {
            container_port = 50051
          }
          env {
            name  = "PORT"
            value = "50051"
          }
          env {
            name  = "API_TOKEN_FAILURE_RATE"
            value = "0.75"
          }
          env {
            name  = "SERIALIZATION_FAILURE_RATE"
            value = "0.0"
          }
          env {
            name  = "SUCCESS_PAYMENT_SERVICE_DURATION_MILLIS"
            value = "200"
          }
          env {
            name  = "ERROR_PAYMENT_SERVICE_DURATION_MILLIS"
            value = "500"
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

          liveness_probe {
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:50051"]
            }
          }
          readiness_probe {
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:50051"]
            }
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
        }
      }
    }
  }
}

resource "kubernetes_service" "paymentservice" {
  metadata {
    name = "paymentservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.paymentservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 50051
      target_port = 50051
    }

    type = "ClusterIP"
  }
}


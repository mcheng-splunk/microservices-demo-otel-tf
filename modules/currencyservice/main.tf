resource "kubernetes_deployment" "currencyservice" {
  metadata {
    name = "currencyservice"
    labels = {
      app = "currencyservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "currencyservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "currencyservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        container {
          image = "quay.io/signalfuse/microservices-demo-currencyservice:latest"
          name  = "server"

          port {
            container_port = 7000
          }
          env {
            name  = "PORT"
            value = "7000"
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
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:7000"]
            }
          }
          readiness_probe {
            period_seconds = 5
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:7000"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "currencyservice" {
  metadata {
    name = "currencyservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.currencyservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 7000
      target_port = 7000
    }

    type = "ClusterIP"
  }
}


resource "kubernetes_deployment" "emailservice" {
  metadata {
    name = "emailservice"
    labels = {
      app = "emailservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "emailservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "emailservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        container {
          image = "quay.io/signalfuse/microservices-demo-emailservice:latest"
          name  = "server"

          port {
            container_port = 8080
          }
          env {
            name  = "PORT"
            value = "8080"
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

resource "kubernetes_service" "emailservice" {
  metadata {
    name = "emailservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.emailservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 5000
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


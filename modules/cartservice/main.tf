resource "kubernetes_deployment" "cartservice" {
  metadata {
    name = "cartservice"
    labels = {
      app = "cartservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "cartservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "cartservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        container {
          image = "quay.io/signalfuse/microservices-demo-cartservice:latest"
          name  = "server"

          port {
            container_port = 7070
          }
          env {
            name  = "REDIS_ADDR"
            value = "redis-cart:6379"
          }
          env {
            name  = "PORT"
            value = "7070"
          }

          env {
            name  = "LISTEN_ADDR"
            value = "0.0.0.0"
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
            name  = "SIGNALFX_SERVICE_NAME"
            value = "cartservice"
          }

          env {
            name  = "SIGNALFX_SERVER_TIMING_CONTEXT"
            value = "true"
          }

          env {
            name  = "SIGNALFX_TRACE_DEBUG"
            value = "true"
          }
          env {
            name  = "SIGNALFX_ENV"
            value = "demo"
          }
          env {
            name  = "EXTERNAL_DB_NAME"
            value = "Galactus.Postgres"
          }
          env {
            name  = "EXTERNAL_DB_ACCESS_RATE"
            value = "0.75"
          }
          env {
            name  = "EXTERNAL_DB_MAX_DURATION_MILLIS"
            value = "750"
          }
          env {
            name  = "EXTERNAL_DB_ERROR_RATE"
            value = "0.0"
          }

          resources {
            limits = {
              cpu    = "300m"
              memory = "128Mi"
            }
            requests = {
              cpu    = "200m"
              memory = "64Mi"
            }
          }
          liveness_probe {
            period_seconds        = 10
            initial_delay_seconds = 15
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
            }
          }
          readiness_probe {
            initial_delay_seconds = 15
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cartservice" {
  metadata {
    name = "cartservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.cartservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 7070
      target_port = 7070
    }

    type = "ClusterIP"
  }
}
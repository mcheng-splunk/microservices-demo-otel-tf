resource "kubernetes_deployment" "adservice" {
  metadata {
    name = "adservice"
    labels = {
      app = "adservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "adservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "adservice"
        }
      }
      spec {
        termination_grace_period_seconds = 5

        init_container {
          name  = "sfx-instrumentation"
          image = "quay.io/signalfuse/sfx-zero-config-agent:latest"
          volume_mount {
            mount_path = "/opt/sfx"
            name       = "sfx-instrumentation"
          }
        }

        container {
          image = "quay.io/signalfuse/microservices-demo-adservice:latest"
          name  = "server"

          port {
            container_port = 9555
          }

          env {
            name  = "OTEL_EXPORTER_ZIPKIN_SERVICE_NAME"
            value = "adservice"
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
            name  = "OTEL_EXPORTER"
            value = "zipkin"
          }

          env {
            name  = "JAVA_TOOL_OPTIONS"
            value = "-javaagent:/opt/sfx/splunk-otel-javaagent-all.jar"
          }

          resources {
            limits = {
              cpu    = "300m"
              memory = "300Mi"
            }
            requests = {
              cpu    = "200m"
              memory = "180Mi"
            }
          }
          # liveness_probe {
          #   period_seconds = 30
          #   initial_delay_seconds = 60
          #   exec {
          #     command = ["/bin/grpc_health_probe", "-addr=:9555"]
          #   }
          # }
          # readiness_probe {
          #   initial_delay_seconds = 60
          #   exec {
          #     command = ["/bin/grpc_health_probe", "-addr=:9555"]
          #   }
          # }

          volume_mount {
            mount_path = "/opt/sfx"
            name       = "sfx-instrumentation"
          }
        }

        volume {
          name = "sfx-instrumentation"
          empty_dir {

          }
        }
      }
    }
  }
}

resource "kubernetes_service" "adservice" {
  metadata {
    name = "adservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.adservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 9555
      target_port = 9555
    }

    type = "ClusterIP"
  }
}
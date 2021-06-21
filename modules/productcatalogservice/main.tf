resource "kubernetes_deployment" "productcatalogservice" {
  metadata {
    name = "productcatalogservice"
    labels = {
      app = "productcatalogservice"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "productcatalogservice"
      }
    }
    template {
      metadata {
        labels = {
          app = "productcatalogservice"
        }
      }
      spec {
        container {
          image = "quay.io/signalfuse/microservices-demo-productcatalogservice:latest"
          name  = "productcatalogservice"

          port {
            container_port = 3550
          }
          env {
            name  = "PORT"
            value = "3550"
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
              command = ["/bin/grpc_health_probe", "-addr=:3550"]
            }
          }
          readiness_probe {
            exec {
              command = ["/bin/grpc_health_probe", "-addr=:3550"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "productcatalogservice" {
  metadata {
    name = "productcatalogservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.productcatalogservice.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "grpc"
      port        = 3550
      target_port = 3550
    }

    type = "ClusterIP"
  }
}


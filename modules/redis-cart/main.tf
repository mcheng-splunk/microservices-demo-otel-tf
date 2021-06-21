resource "kubernetes_deployment" "redis-cart" {
  metadata {
    name = "redis-cart"
    labels = {
      app = "redis-cart"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis-cart"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis-cart"
        }
      }
      spec {
        container {
          image = "redis:alpine"
          name  = "redis"

          port {
            container_port = 6379
          }

          resources {
            limits = {
              cpu    = "125m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "70m"
              memory = "200Mi"
            }
          }
          liveness_probe {
            period_seconds = 5
            tcp_socket {
              port = 6379
            }
          }
          readiness_probe {
            period_seconds = 5
            tcp_socket {
              port = 6379
            }
          }

          volume_mount {
            mount_path = "/data"
            name       = "redis-data"
          }
        }

        volume {
          name = "redis-data"
          empty_dir {

          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis-cart" {
  metadata {
    name = "redis-cart"
  }
  spec {
    selector = {
      app = kubernetes_deployment.redis-cart.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 6379
      target_port = 6379
    }

    type = "ClusterIP"
  }
}


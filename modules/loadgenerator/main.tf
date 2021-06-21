resource "kubernetes_deployment" "loadgenerator" {
  metadata {
    name = "loadgenerator"
    labels = {
      app = "loadgenerator"
    }
    annotations = {
      name  = "sidecar.istio.io/rewriteAppHTTPProber"
      value = "true"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "loadgenerator"
      }
    }
    template {
      metadata {
        labels = {
          app = "loadgenerator"
        }
      }
      spec {
        termination_grace_period_seconds = 5
        restart_policy                   = "Always"
        container {
          image = "quay.io/signalfuse/microservices-demo-loadgenerator:latest"
          name  = "main"

          port {
            container_port = 8089
          }
          env {
            name  = "FRONTEND_ADDR"
            value = "frontend:80"
          }

          env {
            name  = "USERS"
            value = "10"
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "300m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "loadgenerator" {
  metadata {
    name = "loadgenerator"
    # annotations = {
    #   "service.beta.kubernetes.io/aws-load-balancer-internal"                        = "0.0.0.0/0"
    #   "service.beta.kubernetes.io/aws-load-balancer-healthcheck-interval"            = "5"
    #   "service.beta.kubernetes.io/aws-load-balancer-healthcheck-timeout"             = "3"
    #   "service.beta.kubernetes.io/aws-load-balancer-healthcheck-unhealthy-threshold" = "2"
    #   "external-dns.alpha.kubernetes.io/hostname"                                    = "demo-load"
    # }
  }
  spec {
    selector = {
      app = kubernetes_deployment.loadgenerator.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "http"
      port        = 8089
      target_port = 8089
    }

    type = "LoadBalancer"
  }
}


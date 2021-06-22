resource "helm_release" "otel" {
#   name       = "my-nginx"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "nginx"
#   namespace  = "default"

  name       = "my-otel"
  repository = "https://signalfx.github.io/splunk-otel-collector-chart"
  chart      = "splunk-otel-collector"
  namespace  = "default"

#   set {
#     name  = "service.type"
#     value = "NodePort"
#   }
  set {   
    name  = "splunkRealm"
    value = var.SPLUNKREALM
  }

  set {   
    name  = "splunkAccessToken"
    value = var.SPLUNKACCESSTOKEN
  }

  set {   
    name  = "clusterName"
    value = var.CLUSTERNAME
  }


}


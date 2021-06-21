provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}


# provider "google" {
#   project = "{{YOUR GCP PROJECT}}"
#   region  = "us-central1"
#   zone    = "us-central1-c"
# }
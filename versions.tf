terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.3.2"
    }
  }
  required_version = ">= 1.0.0"  
}


This repository deploys the signalfx/microservices-demo using terraform apply. 
---

## Prerequisite
This demo uses code from https://github.com/signalfx/microservices-demo.   
This demo is configured and tested on gke and k3s cluster. 

---
## Update the Kubernetes Credential 

1. Open the `terraform.tfvars`
2. Modify the credentials according to your environment.

## Enable Splunk RUM Instrumentation

To enable the RUM Instrumentation, 

1. Open the `main.tf` file
2. Set the `RUM_ENABLED` flag to "true". Default is "false" as defined inside `terraform.tfvars`
3. Modify the `RUM_REALM` `RUM_AUTH` `RUM_APP_NAME` `RUM_ENVIRONMENT` accordingly

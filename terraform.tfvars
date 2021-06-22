#terraform.tfvars

host = "https://<k8s-cluster>:6443"
client_certificate 	= "<client_certificate>"
client_key		= "<client_key>"
cluster_ca_certificate	= "<cluster_ca_certificate>"


RUM_ENABLED = "false"
RUM_REALM = "us0"
RUM_AUTH = null
RUM_APP_NAME = null
RUM_ENVIRONMENT = null


SPLUNKREALM = "<SPLUNK_REALM>"
  
SPLUNKACCESSTOKEN = "<SPLUNK_TOKEN>"
  
CLUSTERNAME = "<CLUSTER_NAME>"
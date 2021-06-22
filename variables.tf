variable "host" {
  type = string
}


variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "RUM_ENABLED" {
  type    = bool
  default = false
}



variable "RUM_DEBUG" {
  type    = string
  default = null
}

variable "RUM_REALM" {
  type    = string
  default = "us0"
}

variable "RUM_AUTH" {
  type    = string
  default = null
}

variable "RUM_APP_NAME" {
  type    = string
  default = null
}

variable "RUM_ENVIRONMENT" {
  type    = string
  default = null
}


variable "SPLUNKREALM" {
  type    = string
  default = "us0"
}


variable "SPLUNKACCESSTOKEN" {
  type    = string
}

variable "CLUSTERNAME" {
    type = string
}
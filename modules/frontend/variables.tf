# RUM Fields - If the RUM_ENABLED is set to "true", the RUM_<VARIABLES> must be set according.


variable "RUM_ENABLED" {
  type    = bool
  default = "false"
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

## ---------------------
## Provider configuration
## ---------------------

variable "hostname" {
  description = "hostname"
  default = "hello-world"
}

variable "image" {
  description = "os slug id"
  default = "coreos-stable"
}

variable "zone" {
  description = "region in which to manage GCP resources"
  default = "sgp1"
}

variable "cpu" {
  description = "how many cpu core use"
  default = "1"
}

variable "memory" {
  description = "how many memory use"
  default = "512mb"
}

variable "do_token" {
  description = "DO NOT SET ACCESS KEY IN REPO."
}



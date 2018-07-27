## ---------------------
## Provider configuration
## ---------------------
variable "brandwidth" {
  description = "brandwidth use"
  default = 1
}

variable "hostname" {
  description = "hostname"
  default = "hello-world"
}

variable "image-id" {
  description = "os id"
  default = "coreose"
}

variable "zone" {
  description = "region in which to manage GCP resources"
  default = "pek3"
}

variable "cpu" {
  description = "how many cpu core use"
  default = "1"
}

variable "memory" {
  description = "how many memory use"
  default = "1024"
}

variable "access_key" {
  description = "DO NOT SET ACCESS KEY IN REPO."
}

variable "secret_key" {
  description = "DO NOT SET SECRET KEY IN REPO."
}


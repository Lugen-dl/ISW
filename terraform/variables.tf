variable "do_token" {
  sensitive = true
  default = true
}

variable "tagging" {
  type = string
  default = true
}

variable "is_production" {
  type = bool
  default = true
}

variable "region" {
  type = string
  default = "fra1"
}

variable "droplet_id" {
  type = list(string)
  default = [ ]
}

variable "registry_name" {
  type = string
  default = true
}

variable "s3_secret" {
  default = true
  sensitive = true
}

variable "s3_access" {
  type = string
  default = true
}
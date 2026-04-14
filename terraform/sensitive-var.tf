variable "do_token" {
  sensitive = true
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

variable "cloudflare_api" {
  sensitive = true
  default = true
}
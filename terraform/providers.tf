terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
    http = {
        source = "hashicorp/http"
        version = "~> 3.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
  spaces_access_id = var.s3_access
  spaces_secret_key = var.s3_secret
}


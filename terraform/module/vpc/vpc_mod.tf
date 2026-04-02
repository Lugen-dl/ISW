terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}


resource "digitalocean_vpc" "vpc_id" {
  name = "vpc"
  region = "fra1"
}
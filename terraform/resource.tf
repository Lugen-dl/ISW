resource "digitalocean_droplet" "web" {
    name = var.is_production ? "prod-server" : "dev-server"
    size = var.is_production ? "s-2vcpu-2gb" : "s-1vcpu-1gb"
    image = "docker-20-04"
    region = var.region

    ssh_keys = [ digitalocean_ssh_key.ssh_id.id ]
    tags = [ var.tagging ]
  
user_data = <<-_EOF_
#!/bin/bash

sudo apt update
snap install doctl 

_EOF_
}


module "firewall" {
  source = "./module/firewall"
  tag = [ digitalocean_tag.master_tag.id ]
  my_public_ip = trimspace(data.http.http_id.response_body)
  ld_id = module.loadblancer.lb_id
}

#module "s3" {
#  source = "./module/s3bucket"
#  tag = var.tagging
#}

module "registry" {
  source = "./module/registry"
  tag = var.tagging
  region = var.region
  name = var.registry_name
}

module "vpc" {
  source = "./module/vpc"
}

module "loadblancer" {
  source = "./module/loadbalancer"
  tag = digitalocean_tag.master_tag.id
}

resource "digitalocean_tag" "master_tag" {
  name = var.tagging
}

data "http" "http_id" {
  url = "http://icanhazip.com"
}

resource "digitalocean_droplet" "web" {
    name = var.is_production ? "prod-server" : "dev-server"
    size = var.is_production ? "s-2vcpu-2gb" : "s-1vcpu-1gb"
    image = "docker-20-04"
    region = var.region

    ssh_keys = [ digitalocean_ssh_key.default.id ]
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
  ld_id = module.loadbalancer.lb_id
}


module "bucket" {
  source = "./module/s3bucket"
  tag = var.tagging
  region = var.region

  #What will be stored in bucket
  ssh_key = tls_private_key.private_key.private_key_pem
  ssh_path = "keys/id_rsa"
}

module "registry" {
  source = "./module/registry"
  tag = var.tagging
  region = var.region
  name = var.registry_name
}

module "vpc" {
  source = "./module/vpc"
}

module "loadbalancer" {
  source = "./module/loadbalancer"
  tag = digitalocean_tag.master_tag.id
}

resource "digitalocean_tag" "master_tag" {
  name = var.tagging
}

output "droplet_ip" {
  value = digitalocean_droplet.web.ipv4_address
}

output "private_key" {
  value = tls_private_key.private_key.private_key_pem
  sensitive = true
}

data "http" "http_id" {
  url = "http://icanhazip.com"
}

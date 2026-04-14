resource "digitalocean_droplet" "web" {
    name = var.is_production ? "prod-server" : "dev-server"
    size = var.is_production ? "s-2vcpu-2gb" : "s-1vcpu-1gb"
    image = "docker-20-04"
    region = var.region

    ssh_keys = [ digitalocean_ssh_key.default.id ]
    tags = [ var.tagging ]
    vpc_uuid = module.vpc.vpc_uuid
  
user_data = <<-_EOF_
#!/bin/bash

sudo apt update
snap install doctl 

_EOF_
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

terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

resource "digitalocean_loadbalancer" "load_id" {
  name = "loadblancer"
  region = "fra1"
  droplet_tag = var.tag

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"

  }

  healthcheck {
    port = 80
    protocol = "http"
    path = "/"
  }
}

output "lb_id" {
  value = digitalocean_loadbalancer.load_id.id
}
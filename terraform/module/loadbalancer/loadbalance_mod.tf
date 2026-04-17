terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

resource "digitalocean_certificate" "certificate" {
  name = "web-server-cert"
  type = "lets_encrypt" #Creating free ssl certificate for our web address
  domains = [ "isw-pet-project.site" ]
  
  #If cert was updated, it will restart right now
  lifecycle {
    create_before_destroy = true  
  }
}


resource "digitalocean_loadbalancer" "load_id" {
  name = "loadbalancer"
  region = "fra1"
  droplet_tag = var.tag

  forwarding_rule {
    entry_port = 443
    entry_protocol = "https"

    target_port = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.certificate.name
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
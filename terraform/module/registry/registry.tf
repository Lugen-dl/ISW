terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

resource "digitalocean_container_registries" "docker_registry" {
  name = var.name
  subscription_tier_slug = "starter"
  region = var.region
}

output "registry_endpoint" {
  value = digitalocean_container_registries.docker_registry.server_url
}

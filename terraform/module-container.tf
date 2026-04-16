#Creating our firewall for safe connection
module "firewall" {
  source = "./module/firewall"
  tag = [ digitalocean_tag.master_tag.id ]
  my_public_ip = trimspace(data.http.http_id.response_body)
  ld_id = module.loadbalancer.lb_id
}

#Registry for docker imagest
module "registry" {
  source = "./module/registry"
  tag = var.tagging
  region = var.region
  name = var.registry_name
}
#Our local data storage in private network
module "vpc" {
  source = "./module/vpc"
}
#Evenly distributes incoming resources and prevents server overload
module "loadbalancer" {
  source = "./module/loadbalancer"
  tag = digitalocean_tag.master_tag.id
}

module "s3bucket" {
  source = "./module/s3spaces"
  bucket_name = "my-unique-terraform-state-2024"
  region      = "ams3"
}
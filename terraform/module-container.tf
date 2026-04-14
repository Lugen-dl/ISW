#Creating our firewall for safe connection
module "firewall" {
  source = "./module/firewall"
  tag = [ digitalocean_tag.master_tag.id ]
  my_public_ip = trimspace(data.http.http_id.response_body)
  ld_id = module.loadbalancer.lb_id
}

#Bucket for containing variables
module "bucket" {
  source = "./module/s3bucket"
  tag = var.tagging
  region = var.region

  #What will be stored in bucket
  ssh_key = tls_private_key.private_key.private_key_pem
  ssh_path = "keys/id_rsa"
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
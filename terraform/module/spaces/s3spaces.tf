resource "digitalocean_spaces_bucket" "tf_state_storage" {
  name   = var.bucket_name
  region = var.region

  force_destroy = false 
  acl = "private"
}

output "bucket_domain_name" {
  value = digitalocean_spaces_bucket.tf_state_storage.bucket_domain_name
}

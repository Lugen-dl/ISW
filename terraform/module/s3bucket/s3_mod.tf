terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

#Creating our bucket
resource "digitalocean_spaces_bucket" "bucket_id" {
  name = "unique-s3-bucket-iac-isw11"
  region = var.region
  acl = "public-read"
}

#Creating a FILE that will be stored in our bucket (in this case, ssh-key)
resource "digitalocean_spaces_bucket_object" "private_key" {
  region = var.region
  bucket = digitalocean_spaces_bucket.bucket_id.name
  key = var.ssh_path
  content = var.ssh_key
  content_type = "text/plain"
  acl = "private"
}

#Tfvar file for hand-deletion
resource "digitalocean_spaces_bucket_object" "tfvars" {
  region = var.region
  bucket = digitalocean_spaces_bucket.bucket_id.name
  key = "keys/terraform.tfvars"
  content = "terraform.tfvars"
  content_type = "text/plain"
  acl = "private"
}

#Our bucket URL
output "bucket" {
  description = "bucket"
  value = digitalocean_spaces_bucket.bucket_id.bucket_domain_name
}
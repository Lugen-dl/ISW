terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

resource "digitalocean_spaces_bucket" "bucket_id" {
  name = "unique-s3-bucket-isw"
  region = "fra1"
  acl = "public-read"
}

output "bucket" {
  description = "bucket"
  value = digitalocean_spaces_bucket.bucket_id.bucket_domain_name
}
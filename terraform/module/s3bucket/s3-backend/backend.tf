terraform {
  backend "s3" {
    endpoint = "${var.region}.digitaloceanspaces.com"
    bucket = "unique-s3-bucket-isw"
    key = "terraform.tfstate"
    region = "us-east-1"
    tag = var.tag


    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}


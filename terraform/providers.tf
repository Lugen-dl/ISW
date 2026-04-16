terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
    http = {
        source = "hashicorp/http"
        version = "~> 3.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "tf-state"
    key = "keys/terraform.tfstate"
    region = "us-east-1"

    endpoint =  "https://digitaloceanspaces.com"

    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true
    skip_region_validation = true
    force_path_style = true
  }
}

provider "digitalocean" {
  token = var.do_token
  spaces_access_id = var.s3_access
  spaces_secret_key = var.s3_secret
}

provider "cloudflare" {
  api_token = var.cloudflare_api
}


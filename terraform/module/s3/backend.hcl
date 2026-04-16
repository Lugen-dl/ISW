bucket = "tf-state"
key = "keys/terraform.tfstate"
region = "us-east-1"

endpoint =  "https://ams3.digitalocean.com"

access_key = var.s3_access
secret_key = var.s3_secret

skip_credentials_validation = true
skip_metadata_api_check = true
skip_region_validation = true
force_path_style = true


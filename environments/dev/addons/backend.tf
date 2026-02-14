terraform {
  backend "s3" {
    bucket         = "button0-dev-186582695522-eu-central-1-tfstate"
    key            = "button0/dev/addons/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "button0-dev-tf-locks"
    encrypt        = true
  }
}
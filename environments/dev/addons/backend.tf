terraform {
  backend "s3" {
    bucket         = "button0-terraform-state-186582695522"
    key            = "button0/dev/addons/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "button0-terraform-locks"
    encrypt        = true
  }
}
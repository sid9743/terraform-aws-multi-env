terraform {
  backend "s3" {
    bucket         = "jsv-terraform-state-ap-south-1"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

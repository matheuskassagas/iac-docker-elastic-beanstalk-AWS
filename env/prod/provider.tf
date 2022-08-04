terraform {
    backend "s3" {
    bucket = "mgk-terraform-state"
    key = "iac-docker-elastic-prod/terraformstate"
    region = "us-east-1"
  }
}
terraform {
    backend "s3" {
    bucket = "mgk-terraform-state"
    key = "iac-docker-beanstalk-prod/terraformstate"
    region = "us-east-1"
  }
}
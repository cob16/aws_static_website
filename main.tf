terraform {
  required_version = ">= 0.12.29"

  required_providers {
    aws = "~> 2.62"
  }

  backend "s3" {}
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.16.0"

  namespace = var.namespace
  stage     = "prod"
  name      = "personal-website"
  delimiter = "-"

  tags = {
    "environment-name" = terraform.workspace
  }
}

module "static_website" {
  source = "./modules/static_website"

  providers = {
    aws     = aws
    aws.foo = aws.us_east_1
  }

  prefix = module.label.id
  tags   = module.label.tags

  email_mx_records = var.email_mx_records
  main_txt_records = var.main_txt_records
  namespace        = var.namespace
  website_name     = var.website_name
}

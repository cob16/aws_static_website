terraform {
  required_version = ">= 0.12.25"

  required_providers {
    aws = "~> 2.62"
  }
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
  stage     = terraform.workspace
  name      = "personal-website"
  delimiter = "-"

  tags = {
    "environment-name" = terraform.workspace
  }
}

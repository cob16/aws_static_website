terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.2.0"
    }
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 1.8.0"
    }
  }

  backend "s3" {}
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

provider "pagerduty" {
  token = var.pagerduty_token
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.22.1"

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
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  prefix = module.label.id
  tags   = module.label.tags

  namespace           = var.namespace
  website_name        = var.website_name
  dns_ttl             = var.dns_ttl
  email_mx_records    = var.email_mx_records
  main_txt_records    = var.main_txt_records
  extra_a_records     = var.extra_a_records
  extra_aaaa_records  = var.extra_aaaa_records
  extra_txt_records   = var.extra_txt_records
  extra_cname_records = var.extra_cname_records
}

data "aws_caller_identity" "current" {}

module "general_alarms_sns" {
  source = "./modules/sns_topic"

  providers = {
    aws = aws.us_east_1
  }

  name       = "${module.label.id}-general-alarms"
  account_id = data.aws_caller_identity.current.account_id
  tags       = module.label.tags
}

module "website_monitoring" {
  source = "./modules/website_monitoring"

  providers = {
    aws = aws.us_east_1
  }

  prefix = module.label.id
  tags   = module.label.tags

  account_id                       = data.aws_caller_identity.current.account_id
  distribution_id                  = module.static_website.distribution_id
  cloudwatch_general_alarm_sns_arn = module.general_alarms_sns.arn
}

module "pagerduty" {
  source = "./modules/pagerduty"

  providers = {
    aws       = aws.us_east_1
    pagerduty = pagerduty
  }

  website_name = var.website_name
  sns_topic    = module.general_alarms_sns.arn
}

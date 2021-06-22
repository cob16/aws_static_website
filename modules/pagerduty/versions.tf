terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    pagerduty = {
      source = "pagerduty/pagerduty"
    }
  }
  required_version = ">= 1.0"
}

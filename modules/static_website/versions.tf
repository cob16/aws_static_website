terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.9.0"
      configuration_aliases = [aws, aws.us_east_1]
    }
  }
  required_version = ">= 1.0"
}

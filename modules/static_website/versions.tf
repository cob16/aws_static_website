terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.14.1"
      configuration_aliases = [aws, aws.us_east_1]
    }
  }
  required_version = "~> 1.13.3"
}

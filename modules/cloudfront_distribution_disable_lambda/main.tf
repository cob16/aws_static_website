terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }
}

locals {
  name = "cloudfront_disable_${replace(var.website_name, ".", "_")}"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_function" "cloudfront_distro_disable_lambda" {
  function_name = local.name
  role          = aws_iam_role.cloudfront_distro_disable_lambda.arn
  runtime       = "python3.13"

  filename         = "lambda_function_payload.zip"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  handler          = "lambda.lambda_handler"

  timeout = 30

  environment {
    variables = {
      DISTRIBUTION_ID : var.cloudfront_distribution_id
    }
  }
}
data "aws_iam_policy_document" "cloudfront_distro_disable_lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "cloudfront_distro_disable_lambda" {
  name                  = local.name
  assume_role_policy    = data.aws_iam_policy_document.cloudfront_distro_disable_lambda.json
  force_detach_policies = true
}

data "aws_iam_policy_document" "disable_cloudfront_distribution" {
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:GetDistributionConfig",
      "cloudfront:UpdateDistribution"
    ]
    resources = [
      provider::aws::arn_build("aws", "cloudfront", "", var.account_id, "distribution/${var.cloudfront_distribution_id}")
    ]
  }
}

resource "aws_iam_policy" "disable_cloudfront_distribution" {
  name_prefix = "disable_cloudfront_distribution"
  policy      = data.aws_iam_policy_document.disable_cloudfront_distribution.json
}

resource "aws_iam_role_policy_attachments_exclusive" "cloudfront_distro_disable_lambda" {
  role_name = aws_iam_role.cloudfront_distro_disable_lambda.name
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    aws_iam_policy.disable_cloudfront_distribution.arn
  ]
}
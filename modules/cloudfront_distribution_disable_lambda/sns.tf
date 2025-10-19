resource "aws_sns_topic" "cloudfront_distribution_disable" {
  name = "cloudfront_distribution_disable"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.cloudfront_distribution_disable.arn
  policy = data.aws_iam_policy_document.allow_aws_budget_service.json
}

data "aws_iam_policy_document" "allow_aws_budget_service" {
  statement {
    sid = "__default_policy_ID"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "arn:aws:iam::${var.account_id}:root",
      ]
    }
    resources = [
      aws_sns_topic.cloudfront_distribution_disable.arn
    ]
  }
  statement {
    sid     = "Allow_Publish_Alarms"
    actions = ["sns:Publish"]
    principals {
      identifiers = ["budgets.amazonaws.com"]
      type        = "Service"
    }
    resources = [
      aws_sns_topic.cloudfront_distribution_disable.arn
    ]
  }
}

resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudfront_distro_disable_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.cloudfront_distribution_disable.arn
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.cloudfront_distribution_disable.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.cloudfront_distro_disable_lambda.arn
}
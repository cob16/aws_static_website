resource "aws_sns_topic" "this" {
  name = var.name
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.allow-sws-service-sns.json
}

data "aws_iam_policy_document" "allow-sws-service-sns" {
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
      aws_sns_topic.this.arn
    ]
  }
  statement {
    sid = "Allow_Publish_Alarms"
    actions = [
      "sns:Publish"
    ]
    principals {
      identifiers = ["cloudwatch.amazonaws.com"]
      type        = "Service"
    }
    resources = [
      aws_sns_topic.this.arn
    ]
  }
}
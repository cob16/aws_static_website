//refrences https://gist.github.com/nagelflorian/67060ffaf0e8c6016fa1050b6a4e767a

resource "aws_s3_bucket_public_access_block" "website" {
  bucket                  = var.website_name
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "website" {
  bucket = var.website_name
  acl    = "private"

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "public_read_for_get_bucket_objects" {
  bucket = aws_s3_bucket.website.bucket
  policy = data.aws_iam_policy_document.public_read_for_get_bucket_objects.json
}

data "aws_iam_policy_document" "public_read_for_get_bucket_objects" {
  version = "2008-10-17"
  statement {
    sid    = "PublicReadForGetBucketObjects"
    effect = "Allow"
    principals {
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
      type        = "AWS"
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.website.arn}/*"
    ]
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.prefix
}

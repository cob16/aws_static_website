resource "aws_cloudfront_distribution" "www_distribution" {
  provider = aws.us_east_1
  tags     = module.label.tags

  price_class = "PriceClass_100"

  // origin is where CloudFront gets its content from.
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = var.website_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  // All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id = var.website_name
    min_ttl          = 0
    default_ttl      = 86400
    max_ttl          = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = [var.website_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = aws_acm_certificate.certificate.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
  }

  depends_on = [aws_acm_certificate.certificate]
}
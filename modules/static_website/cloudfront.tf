resource "aws_cloudfront_distribution" "www_distribution" {
  provider = aws.us_east_1

  price_class = "PriceClass_All"
  web_acl_id  =  null //aws will create and manage this automaticly

  // origin is where CloudFront gets its content from.
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = var.website_name
    origin_access_control_id = aws_cloudfront_origin_access_control.www.id
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

    cache_policy_id = data.aws_cloudfront_cache_policy.caching_optimized.id
  }

  aliases = [var.website_name, "www.${var.website_name}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate_validation.main.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 400
    response_code         = 404
    response_page_path    = "/404.html"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 404
    response_page_path    = "/404.html"
  }

  lifecycle {
    ignore_changes = [web_acl_id] //aws will create and manage this automaticly
  }
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  //https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_control" "www" {
  name                              = var.website_name
  description                       = "Access ${var.website_name} bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

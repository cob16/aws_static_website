// refrences https://medium.com/runatlantis/hosting-our-static-site-over-ssl-with-s3-acm-cloudfront-and-terraform-513b799aec0f

resource "aws_acm_certificate" "certificate" {
  provider = aws.us_east_1 //cloudfront foreces the region to this location

  // We want a wildcard cert so we can host subdomains later.
  domain_name       = "*.${var.website_name}"
  validation_method = "EMAIL"

  // We also want the cert to be valid for the root domain even though we'll be
  // redirecting to the www. domain immediately.
  subject_alternative_names = [var.website_name]

  lifecycle {
    create_before_destroy = true
  }
}

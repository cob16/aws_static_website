// references https://medium.com/runatlantis/hosting-our-static-site-over-ssl-with-s3-acm-cloudfront-and-terraform-513b799aec0f

resource "aws_acm_certificate" "certificate" {
  provider = aws.us_east_1 //cloudfront forces the region to this location

  domain_name       = var.website_name
  validation_method = "DNS"

  subject_alternative_names = ["www.${var.website_name}"]

  lifecycle {
    create_before_destroy = true
  }
}

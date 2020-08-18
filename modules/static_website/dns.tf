resource "aws_route53_zone" "main" {
  name    = var.website_name
  comment = "Managed by Terraform"

  tags = var.tags
}

resource "aws_route53_record" "main-a-record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "main-aaaa-record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = ""
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a-record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "extra_a_records" {
  for_each = var.extra_a_records

  zone_id = aws_route53_zone.main.zone_id
  ttl     = var.dns_ttl
  type    = "A"

  name    = each.key
  records = each.value
}

resource "aws_route53_record" "extra_aaaa_records" {
  for_each = var.extra_aaaa_records

  zone_id = aws_route53_zone.main.zone_id
  ttl     = var.dns_ttl
  type    = "AAAA"

  name    = each.key
  records = each.value
}

resource "aws_route53_record" "email_mx_records" {
  zone_id = aws_route53_zone.main.zone_id

  type    = "MX"
  name    = ""
  ttl     = var.dns_ttl
  records = var.email_mx_records
}

resource "aws_route53_record" "main_txt_records" {
  zone_id = aws_route53_zone.main.zone_id

  name    = ""
  type    = "TXT"
  ttl     = var.dns_ttl
  records = var.main_txt_records
}

resource "aws_route53_record" "extra_txt_records" {
  for_each = var.extra_txt_records

  zone_id = aws_route53_zone.main.zone_id
  type    = "TXT"
  ttl     = var.dns_ttl

  name    = each.key
  records = each.value
}

resource "aws_route53_record" "extra_cname_records" {
  for_each = var.extra_cname_records

  zone_id = aws_route53_zone.main.zone_id
  type    = "CNAME"
  ttl     = var.dns_ttl

  name    = each.key
  records = each.value
}
output "aws_cloudfront_distribution" {
  value = module.static_website.aws_cloudfront_distribution
}

output "s3_bucket_name" {
  value = module.static_website.s3_bucket_name
}
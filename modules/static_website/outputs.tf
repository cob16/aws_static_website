output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.www_distribution.domain_name
}
output "s3_bucket_name" {
  value = aws_s3_bucket.website.bucket
}
output "distribution_id" {
  value = aws_cloudfront_distribution.www_distribution.id
}

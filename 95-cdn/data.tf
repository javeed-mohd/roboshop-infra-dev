# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# Cloudfront_cache_policy data source(caching_disabled and caching_optimized)
data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

# AWS Certificate Arn data source
data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}
locals {
    caching_optimized   = data.aws_cloudfront_cache_policy.caching_optimized.id
    caching_disabled    = data.aws_cloudfront_cache_policy.caching_disabled.id
    acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
    common_tags = {
        Project     = var.project
        Environment = var.Environment
        Terraform   = "True"
    }
}
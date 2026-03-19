# A CDN (Content Delivery Network) in AWS is mainly provided through Amazon CloudFront. It’s a service that helps deliver your website or application content to users faster and more securely by using a global network of servers.
# Creation of AWS CloudFRont Distribution
resource "aws_cloudfront_distribution" "roboshop" {
  origin {
    # https://frontend-dev.devopsdaws.online
    domain_name              = "frontend-${var.environment}.${var.domain_name}"
    origin_id                = "frontend-${var.environment}.${var.domain_name}"

    # CloudFront custom origin
    custom_origin_config  {
        http_port              = 80         # Required to be set but not used
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1"]
    }
  }

    enabled             = true
    is_ipv6_enabled     = false
  
  # CDN URL https://roboshop-dev.devopsdaws.online (Public or Prod)
  aliases = ["${var.project}-${var.environment}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.caching_disabled
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.caching_optimized
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.caching_optimized
  }

  price_class = "PriceClass_All"

  # We can restrict therestrictions via whitelist(required only), Blacklist(Except that all) and none represents default which allows all countries
  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = ["US", "CA", "GB", "DE"]
    }
  }

  # roboshop-dev-frontend
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-frontend"
    },
    local.common_tags
  )

  viewer_certificate {
    acm_certificate_arn = local.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

# Creation of Route53 records 
resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "${var.project}-${var.environment}.${var.domain_name}"      # roboshop-dev.devopsdaws.online
  type    = "A"
  
  # CDN details (Content delivery network)
  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}
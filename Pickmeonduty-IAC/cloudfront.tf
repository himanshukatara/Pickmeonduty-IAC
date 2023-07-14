######################### Development Environment #################
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  # acl    = "${var.acl_type}"
#   policy = file("s3-policies/policy.json")
  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false
        apply_server_side_encryption_by_default {
                  sse_algorithm = "AES256"
      }
    }
  }
  website {
     index_document = "index.html"
    error_document = "index.html"
  }
  
  versioning {
    enabled    = true
  }
#  tags = {
#    Name        = "Vlogr"
#    Environment = "Dev"
#  }
}

locals {
  s3_origin_id = "${var.s3_origin_id}"
}


#resource "aws_s3_bucket_public_access_block" "bucket-access-block" {
#    bucket = "aws_s3_bucket.bucket.id"
#    block_public_acls = false
#    block_public_policy = false
#    ignore_public_acls = false
#    restrict_public_buckets = false
#}

resource "aws_cloudfront_distribution" "s3_distribution" {
 
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = "index.html"

#  logging_config {
#    include_cookies = true
#    bucket          = "${var.bucket_log}"
#    prefix         = "${var.prefix}"
#  }

  # aliases = ["${var.aliases_name}"]

  default_cache_behavior {
    compress               = true
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 3600
    default_ttl            = 86400
    max_ttl                = 31536000
  }


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations = ["ALL"]
    }
}

  tags = {
    Environment = ""
  }
  
  custom_error_response {
          error_caching_min_ttl = 0
          error_code            = 404
          response_code         = 200
          response_page_path    = "/index.html"
  }
  viewer_certificate {
    #  acm_certificate_arn      = "${var.acm_certificate_arn}"
    cloudfront_default_certificate = true
    ssl_support_method             = "sni-only"
    minimum_protocol_version = "${var.minimum_protocol_version}" 
      }
}


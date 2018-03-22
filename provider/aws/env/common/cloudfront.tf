resource "aws_cloudfront_distribution" "my-distribution" {

    enabled                                     = true
    is_ipv6_enabled                             = true
    aliases                                     = "${var.distribution_name_config}"
    comment                                     = "my-distribution distribution name"

    origin {
        domain_name                             = "${lookup(var.cloudfront_config, "domain_name")}"
        origin_id                               = "${lookup(var.cloudfront_config, "origin_id")}"

        custom_origin_config {
            http_port                           = "${lookup(var.cloudfront_config, "http_port")}"
            https_port                          = "${lookup(var.cloudfront_config, "https_port")}"
            origin_keepalive_timeout            = "${lookup(var.cloudfront_config, "origin_keepalive_timeout")}"
            origin_protocol_policy              = "${lookup(var.cloudfront_config, "origin_protocol_policy")}"
            origin_read_timeout                 = "${lookup(var.cloudfront_config, "origin_read_timeout")}"
            origin_ssl_protocols                = "${var.origin_ssl_protocols}"
        }
    }

    restrictions {
        geo_restriction {
            restriction_type                    = "${lookup(var.cloudfront_config, "restriction_type")}"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate          = "${lookup(var.cloudfront_config, "cloudfront_default_certificate")}"
        acm_certificate_arn                     = "${lookup(var.cloudfront_config, "acm_arn")}"
        minimum_protocol_version                = "${lookup(var.cloudfront_config, "minimum_protocol_version")}"
        ssl_support_method                      = "${lookup(var.cloudfront_config, "ssl_support_method")}"
    }

    default_cache_behavior {
        allowed_methods                         = "${var.behavior_allowed_method}"
        cached_methods                          = "${var.behavior_cached_method}"
        target_origin_id                        = "${lookup(var.cloudfront_config, "origin_id")}"

        forwarded_values {
            query_string                        = true

            cookies {
                forward                         = "none"
            }
        }

        compress                                = true
        viewer_protocol_policy                  = "${lookup(var.cloudfront_config, "viewer_protocol_policy")}"
        min_ttl                                 = 0
        max_ttl                                 = 31536000
        default_ttl                             = 86400
    }
}

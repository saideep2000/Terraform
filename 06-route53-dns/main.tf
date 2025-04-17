terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

# Create a public hosted zone for your domain
resource "aws_route53_zone" "primary" {
  name = var.domain_name
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-zone"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create a private hosted zone for internal services
resource "aws_route53_zone" "private" {
  name = "${var.environment}.internal.${var.domain_name}"
  
  # If you want this to be a private hosted zone, you need to specify a VPC
  dynamic "vpc" {
    for_each = var.vpc_id != "" ? [1] : []
    content {
      vpc_id = var.vpc_id
    }
  }
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-private-zone"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Simple A record - points to a static IP
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.web_server_ip]
}

# CNAME record - points to another domain
resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "app.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["www.${var.domain_name}"]
}

# MX records for email
resource "aws_route53_record" "mail" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "MX"
  ttl     = 3600
  records = [
    "10 mail1.${var.domain_name}",
    "20 mail2.${var.domain_name}"
  ]
}

# TXT record for domain verification
resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 include:_spf.${var.domain_name} ~all"]
}

# Private records in private zone
resource "aws_route53_record" "db" {
  count   = var.vpc_id != "" ? 1 : 0
  zone_id = aws_route53_zone.private.zone_id
  name    = "db.${var.environment}.internal.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.db_server_ip]
}

# Alias record pointing to an AWS resource (e.g., ELB)
resource "aws_route53_record" "lb" {
  count   = var.load_balancer_dns_name != "" && var.load_balancer_zone_id != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = true
  }
}

# Weighted routing policy - distributes traffic based on weights
resource "aws_route53_record" "weighted_blue" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "service.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  weighted_routing_policy {
    weight = 80
  }
  
  set_identifier = "blue"
  records        = [var.blue_server_ip]
}

resource "aws_route53_record" "weighted_green" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "service.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  weighted_routing_policy {
    weight = 20
  }
  
  set_identifier = "green"
  records        = [var.green_server_ip]
}

# Failover routing policy - primary and secondary endpoints
resource "aws_route53_health_check" "primary" {
  count             = var.primary_server_ip != "" ? 1 : 0
  fqdn              = "primary.${var.domain_name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30
  
  tags = {
    Name = "primary-health-check"
  }
}

resource "aws_route53_record" "failover_primary" {
  count   = var.primary_server_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "failover.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  failover_routing_policy {
    type = "PRIMARY"
  }
  
  health_check_id = aws_route53_health_check.primary[0].id
  set_identifier  = "primary"
  records         = [var.primary_server_ip]
}

resource "aws_route53_record" "failover_secondary" {
  count   = var.secondary_server_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "failover.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  failover_routing_policy {
    type = "SECONDARY"
  }
  
  set_identifier = "secondary"
  records        = [var.secondary_server_ip]
}

# Latency-based routing - routes users to the lowest latency region
resource "aws_route53_record" "latency_us_east" {
  count   = var.us_east_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "global.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  latency_routing_policy {
    region = "us-east-1"
  }
  
  set_identifier = "us-east"
  records        = [var.us_east_ip]
}

resource "aws_route53_record" "latency_us_west" {
  count   = var.us_west_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "global.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  latency_routing_policy {
    region = "us-west-2"
  }
  
  set_identifier = "us-west"
  records        = [var.us_west_ip]
}

resource "aws_route53_record" "latency_eu_west" {
  count   = var.eu_west_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "global.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  latency_routing_policy {
    region = "eu-west-1"
  }
  
  set_identifier = "eu-west"
  records        = [var.eu_west_ip]
}

# Geolocation-based routing - routes based on user location
resource "aws_route53_record" "geo_us" {
  count   = var.us_geo_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "geo.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  geolocation_routing_policy {
    country = "US"
  }
  
  set_identifier = "us"
  records        = [var.us_geo_ip]
}

resource "aws_route53_record" "geo_eu" {
  count   = var.eu_geo_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "geo.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  geolocation_routing_policy {
    continent = "EU"
  }
  
  set_identifier = "eu"
  records        = [var.eu_geo_ip]
}

resource "aws_route53_record" "geo_default" {
  count   = var.default_geo_ip != "" ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = "geo.${var.domain_name}"
  type    = "A"
  ttl     = 300
  
  geolocation_routing_policy {
    country = "*"
  }
  
  set_identifier = "default"
  records        = [var.default_geo_ip]
}
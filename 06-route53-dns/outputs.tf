output "public_zone_id" {
  description = "ID of the public Route53 hosted zone"
  value       = aws_route53_zone.primary.zone_id
}

output "public_zone_name_servers" {
  description = "Name servers for the public hosted zone"
  value       = aws_route53_zone.primary.name_servers
}

output "private_zone_id" {
  description = "ID of the private Route53 hosted zone"
  value       = aws_route53_zone.private.zone_id
}

output "www_record_fqdn" {
  description = "FQDN of the www A record"
  value       = aws_route53_record.www.fqdn
}

output "app_record_fqdn" {
  description = "FQDN of the app CNAME record"
  value       = aws_route53_record.app.fqdn
}

output "weighted_record_fqdn" {
  description = "FQDN of the weighted routing record"
  value       = aws_route53_record.weighted_blue.fqdn
}

output "failover_record_fqdn" {
  description = "FQDN of the failover routing record"
  value       = length(aws_route53_record.failover_primary) > 0 ? aws_route53_record.failover_primary[0].fqdn : null
}

output "latency_record_fqdn" {
  description = "FQDN of the latency routing record"
  value       = length(aws_route53_record.latency_us_east) > 0 ? aws_route53_record.latency_us_east[0].fqdn : null
}

output "geo_record_fqdn" {
  description = "FQDN of the geolocation routing record"
  value       = length(aws_route53_record.geo_us) > 0 ? aws_route53_record.geo_us[0].fqdn : null
}

output "dns_configuration_summary" {
  description = "Summary of DNS records configured"
  value = {
    standard_records = {
      www  = "A record pointing to ${var.web_server_ip}"
      app  = "CNAME record pointing to www.${var.domain_name}"
      mail = "MX records for email services"
      txt  = "TXT record for domain verification"
    }
    advanced_routing = {
      weighted  = "service.${var.domain_name} with Blue (${var.blue_server_ip}) at 80% and Green (${var.green_server_ip}) at 20%"
      failover  = var.primary_server_ip != "" ? "failover.${var.domain_name} with primary and secondary endpoints" : "Not configured"
      latency   = var.us_east_ip != "" ? "global.${var.domain_name} with latency-based routing to multiple regions" : "Not configured"
      geo       = var.us_geo_ip != "" ? "geo.${var.domain_name} with location-based routing" : "Not configured"
    }
  }
}
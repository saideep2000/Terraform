variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-learning"
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "The primary domain name to use for DNS records"
  type        = string
  # No default - must be provided
  default     = "saideepsamineni.com"
}

variable "vpc_id" {
  description = "VPC ID for private hosted zone (optional)"
  type        = string
  default     = ""
}

variable "web_server_ip" {
  description = "IP address of the web server"
  type        = string
  default     = "192.0.2.10"  # Example IP - replace with actual IP
}

variable "db_server_ip" {
  description = "IP address of the database server"
  type        = string
  default     = "192.0.2.20"  # Example IP - replace with actual IP
}

variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer (for alias record)"
  type        = string
  default     = ""
}

variable "load_balancer_zone_id" {
  description = "Zone ID of the load balancer (for alias record)"
  type        = string
  default     = ""
}

variable "blue_server_ip" {
  description = "IP address of the blue environment server"
  type        = string
  default     = "192.0.2.30"  # Example IP - replace with actual IP
}

variable "green_server_ip" {
  description = "IP address of the green environment server"
  type        = string
  default     = "192.0.2.40"  # Example IP - replace with actual IP
}

variable "primary_server_ip" {
  description = "IP address of the primary server (for failover)"
  type        = string
  default     = ""
}

variable "secondary_server_ip" {
  description = "IP address of the secondary server (for failover)"
  type        = string
  default     = ""
}

variable "us_east_ip" {
  description = "IP address in US East region (for latency routing)"
  type        = string
  default     = ""
}

variable "us_west_ip" {
  description = "IP address in US West region (for latency routing)"
  type        = string
  default     = ""
}

variable "eu_west_ip" {
  description = "IP address in EU West region (for latency routing)"
  type        = string
  default     = ""
}

variable "us_geo_ip" {
  description = "IP address for US users (for geolocation routing)"
  type        = string
  default     = ""
}

variable "eu_geo_ip" {
  description = "IP address for EU users (for geolocation routing)"
  type        = string
  default     = ""
}

variable "default_geo_ip" {
  description = "Default IP address (for geolocation routing)"
  type        = string
  default     = ""
}
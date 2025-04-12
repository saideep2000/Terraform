variable "aws_region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "enable_bucket_policy" {
  description = "Enable bucket policy"
  type        = bool
  default     = false
}

variable "allowed_account_ids" {
  description = "List of AWS Account IDs allowed to access the bucket"
  type        = list(string)
  default     = []
}
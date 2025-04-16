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

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  # This has no default and must be provided
}

variable "assets_bucket_name" {
  description = "Name of the S3 bucket for static assets"
  type        = string
  default     = "terraform-learning-assets"
}

variable "processing_bucket_name" {
  description = "Name of the S3 bucket for data processing"
  type        = string
  default     = "terraform-learning-processing"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "terraform-learning-data"
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "terraform-learning-queue"
}
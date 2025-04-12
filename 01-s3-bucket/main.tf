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

# Create S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = "TerraformLearning"
  }
}

# Configure versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.demo_bucket.id
  
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

# Configure public access block (secure by default)
resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Apply bucket policy (optional)
resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.enable_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.demo_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = var.allowed_account_ids
        }
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.demo_bucket.arn}",
          "${aws_s3_bucket.demo_bucket.arn}/*"
        ]
      }
    ]
  })

  # Only apply policy if public access block is configured properly
  depends_on = [aws_s3_bucket_public_access_block.bucket_access]
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.demo_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
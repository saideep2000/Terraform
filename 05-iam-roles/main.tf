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

# EC2 instance role for web servers
resource "aws_iam_role" "web_server_role" {
  name = "${var.project_name}-web-server-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-web-server-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

# IAM policy for web servers - S3 read access
resource "aws_iam_policy" "s3_read_only" {
  name        = "${var.project_name}-s3-read-only"
  description = "Allows read-only access to specific S3 buckets"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.assets_bucket_name}",
          "arn:aws:s3:::${var.assets_bucket_name}/*"
        ]
      }
    ]
  })
}

# Attach S3 read policy to web server role
resource "aws_iam_role_policy_attachment" "web_server_s3_read" {
  role       = aws_iam_role.web_server_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

# Attach SSM policy to web server role for session management
resource "aws_iam_role_policy_attachment" "web_server_ssm" {
  role       = aws_iam_role.web_server_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create instance profile for the web server role
resource "aws_iam_instance_profile" "web_server_profile" {
  name = "${var.project_name}-web-server-profile"
  role = aws_iam_role.web_server_role.name
}

# Lambda execution role
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-lambda-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Custom IAM policy for Lambda to access S3 and DynamoDB
resource "aws_iam_policy" "lambda_s3_dynamodb" {
  name        = "${var.project_name}-lambda-s3-dynamodb"
  description = "Allows Lambda to access S3 and DynamoDB"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.processing_bucket_name}",
          "arn:aws:s3:::${var.processing_bucket_name}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

# Attach Lambda policy to role
resource "aws_iam_role_policy_attachment" "lambda_s3_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_dynamodb.arn
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-ecs-execution-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Attach ECS task execution role policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Role with custom permissions
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-ecs-task-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Custom policy for ECS tasks
resource "aws_iam_policy" "ecs_task_policy" {
  name        = "${var.project_name}-ecs-task-policy"
  description = "Custom policy for ECS tasks"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.processing_bucket_name}",
          "arn:aws:s3:::${var.processing_bucket_name}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:${var.sqs_queue_name}"
      }
    ]
  })
}

# Attach policy to ECS task role
resource "aws_iam_role_policy_attachment" "ecs_task_permissions" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

# S3 bucket policy example
resource "aws_s3_bucket" "logging_bucket" {
  bucket = "${var.project_name}-logging-${var.aws_account_id}"

  tags = {
    Name        = "${var.project_name}-logging"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_policy" "logging_bucket_policy" {
  bucket = aws_s3_bucket.logging_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "logging.s3.amazonaws.com"
        },
        Action = [
          "s3:PutObject"
        ],
        Resource = "${aws_s3_bucket.logging_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount": var.aws_account_id
          }
        }
      }
    ]
  })
}
output "web_server_role_arn" {
  description = "ARN of the IAM role for web servers"
  value       = aws_iam_role.web_server_role.arn
}

output "web_server_instance_profile_name" {
  description = "Name of the instance profile for web servers"
  value       = aws_iam_instance_profile.web_server_profile.name
}

output "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda functions"
  value       = aws_iam_role.lambda_role.arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "s3_read_only_policy_arn" {
  description = "ARN of the S3 read-only IAM policy"
  value       = aws_iam_policy.s3_read_only.arn
}

output "lambda_s3_dynamodb_policy_arn" {
  description = "ARN of the Lambda S3 and DynamoDB access IAM policy"
  value       = aws_iam_policy.lambda_s3_dynamodb.arn
}

output "ecs_task_policy_arn" {
  description = "ARN of the ECS task IAM policy"
  value       = aws_iam_policy.ecs_task_policy.arn
}

output "logging_bucket_name" {
  description = "Name of the logging S3 bucket"
  value       = aws_s3_bucket.logging_bucket.bucket
}

output "logging_bucket_arn" {
  description = "ARN of the logging S3 bucket"
  value       = aws_s3_bucket.logging_bucket.arn
}
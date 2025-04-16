# 05 - IAM Roles and Policies

This is the fifth milestone in the Terraform learning path. In this project, you will:
- Define service roles for different AWS services (EC2, Lambda, ECS)
- Implement least-privilege permissions using custom IAM policies
- Attach policies to resources and understand policy types
- Create an instance profile for EC2 instances

## Learning Objectives

- Understand IAM roles and their relationship to AWS services
- Learn to implement least-privilege security policies
- Create custom IAM policies with appropriate permissions
- Understand the difference between managed and custom policies
- Learn to attach policies to resources with resource-based policies


## Getting Started

1. Copy the example variables file:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your settings:
   - Set your AWS region
   - Set your AWS account ID
   - Configure bucket names and other resources

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Review the plan:
   ```
   terraform plan
   ```

5. Apply the configuration:
   ```
   terraform apply
   ```

6. When finished, you can destroy the resources:
   ```
   terraform destroy
   ```

## IAM Components Created

This configuration creates several IAM components that would be used in a real-world application:

### Roles

1. **EC2 Web Server Role**: For EC2 instances to access allowed AWS services
2. **Lambda Role**: For Lambda functions to access S3 and DynamoDB
3. **ECS Task Execution Role**: For ECS to pull container images and log to CloudWatch
4. **ECS Task Role**: For ECS application containers to access AWS services

### Policies

1. **S3 Read-Only Policy**: Custom policy allowing read-only access to an assets bucket
2. **Lambda S3/DynamoDB Policy**: Custom policy for Lambda to interact with S3 and DynamoDB
3. **ECS Task Policy**: Custom policy for ECS tasks to interact with S3 and SQS
4. **S3 Bucket Policy**: Resource-based policy allowing S3 logging service to write logs

### Attachments and Profiles

1. **Policy Attachments**: Connecting policies to the appropriate roles
2. **Instance Profile**: For attaching the EC2 role to instances

## IAM Best Practices Implemented

This project demonstrates several IAM best practices:

1. **Least Privilege**: Each role has only the permissions it needs, no more
2. **Service-Specific Roles**: Separate roles for different services (EC2, Lambda, ECS)
3. **Resource Restrictions**: Policies specify exact resources (ARNs) rather than "*"
4. **Managed + Custom Policies**: Uses AWS managed policies where appropriate, custom where specific
5. **Condition Keys**: Using condition keys to further restrict access

## Understanding the IAM Configuration

### Trust Relationships

Each IAM role includes a trust relationship (assume role policy) that determines which service can assume the role:

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Effect": "Allow",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    }
  }]
}
```

This trust policy allows only the EC2 service to assume the role.

### Policy Resources

Policies specify exact resources using Amazon Resource Names (ARNs):

```json
"Resource": [
  "arn:aws:s3:::${var.assets_bucket_name}",
  "arn:aws:s3:::${var.assets_bucket_name}/*"
]
```

This limits permissions to only the specified bucket.

### Instance Profiles

For EC2 instances, an instance profile is required to attach a role:

```terraform
resource "aws_iam_instance_profile" "web_server_profile" {
  name = "${var.project_name}-web-server-profile"
  role = aws_iam_role.web_server_role.name
}
```

## Advanced Tasks

Once you're comfortable with the basic IAM role and policy setup, try these enhancements:

1. Implement a permission boundary to further restrict what IAM roles can do
2. Create a cross-account role that allows access from another AWS account
3. Use policy variables to make policies more dynamic
4. Implement Service Control Policies (SCPs) if you have an AWS Organization
5. Add conditional access based on tags

# 02 - Basic VPC with Subnets

This is the second milestone in the Terraform learning path. In this project, you will:
- Define a custom VPC
- Create public and private subnets across multiple availability zones
- Set up an Internet Gateway
- Configure route tables for proper network traffic flow

## Learning Objectives

- Understand AWS networking fundamentals with VPCs
- Create a secure and scalable network architecture
- Learn to use Terraform's count and iteration for creating multiple similar resources
- Understand the relationship between VPCs, subnets, and routing

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed (v1.0.0+)
2. AWS CLI installed and configured with valid credentials
3. AWS account with permissions to create VPC resources

## Getting Started

1. Copy the example variables file:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your preferred settings:
   - Set your AWS region
   - Modify CIDR blocks if needed
   - Adjust availability zones based on your preferred region

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

## Network Architecture

This configuration creates:

1. A VPC with a /16 CIDR block (provides up to 65,536 IP addresses)
2. Two public subnets in different availability zones
3. Two private subnets in different availability zones
4. An Internet Gateway attached to the VPC
5. A public route table with a route to the Internet Gateway
6. A private route table (currently without internet access)
7. Associations between subnets and their respective route tables

The result is a network architecture that follows AWS best practices with:
- High availability across multiple AZs
- Segregation of public and private resources
- Control over what can access the internet

## Understanding Public vs Private Subnets

- **Public Subnets**: Resources in these subnets can receive traffic directly from the internet via the Internet Gateway. They have `map_public_ip_on_launch` enabled, meaning EC2 instances will automatically get public IPs.

- **Private Subnets**: Resources in these subnets cannot be directly accessed from the internet. They can still access the internet for outbound connections if a NAT Gateway is configured (not included in this milestone).

## Advanced Tasks

Once you're comfortable with the basic VPC setup, try these enhancements:

1. Add a NAT Gateway to allow private subnet resources to access the internet
2. Create a bastion host in the public subnet for secure access to private resources
3. Implement network ACLs for additional security controls
4. Set up VPC flow logs for network traffic monitoring


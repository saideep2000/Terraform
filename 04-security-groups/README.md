# 04 - Security Groups Configuration

This is the fourth milestone in the Terraform learning path. In this project, you will:
- Define inbound/outbound rules for different application tiers
- Create application-specific security groups
- Implement security group references for a layered security model

## Learning Objectives

- Understand how to create and configure AWS security groups
- Learn to implement security group references (security group chaining)
- Design a comprehensive security model for a multi-tier application
- Learn best practices for securing different application components


## Getting Started

1. Copy the example variables file:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your preferred settings:
   - Set your AWS region
   - Configure your IP address for SSH access
   - Adjust port numbers if needed

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

## Security Group Architecture

This configuration creates a comprehensive security model for a multi-tier application:

1. **Load Balancer Security Group**
   - Allows HTTP/HTTPS traffic from the internet
   - Positioned at the public-facing edge of the application

2. **Web Server Security Group**
   - Allows HTTP traffic from load balancer security group only
   - Allows SSH from specified IP addresses
   - Provides a second security layer

3. **Application Server Security Group**
   - Allows application port access from web server security group only
   - Allows SSH from specified IP addresses
   - Allows self-referential access for clustering
   - Provides a third security layer

4. **Database Security Group**
   - Allows database port access from application server security group only
   - Strictly limits access to sensitive data
   - Provides the innermost security layer

5. **Bastion Host Security Group**
   - Allows SSH from specified IP addresses
   - Used for secure administrative access

## Security Group References

A key concept implemented in this milestone is security group references, where instead of specifying CIDR blocks, we reference other security groups:

```terraform
ingress {
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  security_groups = [aws_security_group.load_balancer_sg.id]
  description     = "HTTP from load balancer"
}
```

This creates a chain of trust where:
- The database only trusts the application servers
- The application servers only trust the web servers
- The web servers only trust the load balancer
- The load balancer accepts traffic from the internet

This limits the attack surface and follows the principle of least privilege.

## Advanced Security Concepts

This configuration also demonstrates:

1. **Defense in Depth**: Multiple layers of security controls
2. **Traffic Filtering**: Precisely controlling what traffic can flow where
3. **Need-to-Know Access**: Only allowing required communication paths
4. **Separation of Concerns**: Different security groups for different functions

## Advanced Tasks

Once you're comfortable with the basic security group setup, try these enhancements:

1. Add more granular rules based on specific ports and protocols
2. Implement network ACLs as an additional security layer
3. Create security groups for additional services (Redis, Elasticsearch, etc.)
4. Implement time-based conditions for security group rules using Lambda functions

# 03 - EC2 Instance Deployment

This is the third milestone in the Terraform learning path. In this project, you will:
- Provision a basic EC2 compute instance
- Configure instance type and use a dynamic AMI reference
- Create and attach security groups
- Set up SSH access with a key pair
- Deploy a simple web server with user data

## Learning Objectives

- Understand EC2 instance provisioning with Terraform
- Learn to use data sources to find dynamic values like AMIs
- Configure security groups for network access control
- Set up SSH access and understand key pair management
- Use user data scripts for instance initialization

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed (v1.0.0+)
2. AWS CLI installed and configured with valid credentials
3. AWS account with permissions to create EC2 resources
4. SSH key pair (optional, for SSH access)

## Getting Started

1. Copy the example variables file:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your preferred settings:
   - Set your AWS region
   - Configure instance specifications
   - Set your IP address for SSH access (recommended for security)
   - Configure your SSH key pair details

3. If you need to create a new SSH key pair:
   ```
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform-key
   ```

4. Initialize Terraform:
   ```
   terraform init
   ```

5. Review the plan:
   ```
   terraform plan
   ```

6. Apply the configuration:
   ```
   terraform apply
   ```

7. When finished, you can destroy the resources:
   ```
   terraform destroy
   ```

## Accessing Your Instance

After deployment, you can access your EC2 instance in several ways:

1. **SSH Access**: Use the SSH command provided in the outputs:
   ```
   terraform output ssh_command
   ```

   if it's telling that your key-value pair file is open or security risk, run this:
   ```
   chmod 400 ../my-terraform-key-pair.pem
   ```

   

2. **Web Server**: The instance runs a basic web server. Access it in your browser:
   ```
   http://<instance_public_ip>
   
   ```
   You can get the public IP with:
   ```
   terraform output instance_public_ip
   ```

## Security Considerations

This configuration includes:
- A security group allowing SSH access from the specified IP address
- HTTP access from anywhere (for the web server)
- Unrestricted outbound traffic

For production environments, consider:
- Further restricting SSH access to specific IPs
- Using a bastion host for SSH access
- Implementing proper HTTPS instead of HTTP
- Placing the instance in a private subnet with a load balancer in front

## Advanced Tasks

Once you're comfortable with the basic EC2 deployment, try these enhancements:

1. Deploy the instance in a custom VPC using outputs from milestone 2
2. Add an Elastic IP address for a static public IP
3. Implement a more sophisticated user data script
4. Attach additional EBS volumes
5. Create an IAM role and instance profile
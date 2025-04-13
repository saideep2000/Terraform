# 01 - S3 Bucket Deployment

This is the first milestone in the Terraform learning path. In this project, you will:
- Create a simple S3 bucket using Terraform
- Configure basic bucket properties including versioning and encryption
- Apply bucket policies to control access


## Files

- `main.tf` - Contains the main Terraform configuration, including the AWS provider and S3 bucket resources
- `variables.tf` - Defines input variables to make the configuration flexible
- `outputs.tf` - Specifies the values to output after applying the configuration
- `terraform.tfvars.example` - Example variable values (copy to `terraform.tfvars` and customize)



## Getting Started

1. Copy the example variables file:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your preferred settings:
   - Set a globally unique bucket name
   - Choose your preferred AWS region
   - Configure versioning and other options

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

## Advanced Tasks

Once you're comfortable with the basic deployment, try these enhancements:

1. Enable lifecycle rules to automatically transition objects to cheaper storage classes
2. Set up bucket logging to track access
3. Configure CORS settings for web access
4. Create multiple buckets with different configurations using a single Terraform configuration

git add .
git commit -m "fixes #1: Done with the first milestone"
git push
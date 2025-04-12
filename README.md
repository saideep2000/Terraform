# Terraform Learning Path

This repository contains a structured learning path for mastering Terraform, from basic deployments to complex enterprise-grade infrastructure as code implementations.

## Learning Path Overview

This learning path is designed to progressively build your Terraform skills through practical, hands-on projects that increase in complexity. Each milestone represents a specific infrastructure component or pattern that you'll implement using Terraform.

## Prerequisites

- Basic understanding of cloud computing concepts
- AWS account (as most examples use AWS services)
- Terraform installed locally (version 1.0+)
- Git basics
- Command line familiarity

## Milestones

### Beginner Level

1. **Deploying an S3 bucket**
   - Create a simple storage bucket
   - Configure basic bucket properties
   - Apply bucket policies

2. **Creating a basic VPC with subnets**
   - Define a custom VPC
   - Create public and private subnets
   - Set up internet gateway

3. **Launching a single EC2 instance**
   - Provision a basic compute instance
   - Configure instance type and AMI
   - Attach security groups

4. **Setting up security groups**
   - Define inbound/outbound rules
   - Create application-specific security groups
   - Implement security group references

5. **Creating IAM roles and policies**
   - Define service roles
   - Implement least-privilege permissions
   - Attach policies to resources

6. **Configuring Route53 DNS records**
   - Create hosted zones
   - Define record sets
   - Configure routing policies

7. **Implementing CloudWatch alarms**
   - Set up resource monitoring
   - Configure alerting thresholds
   - Create notification actions

### Intermediate Level

8. **Deploying an RDS database instance**
   - Provision managed database
   - Configure subnet groups
   - Set up parameter groups

9. **Setting up auto-scaling groups**
   - Define launch configurations/templates
   - Configure scaling policies
   - Implement health checks

10. **Creating load balancers (ALB/NLB)**
    - Set up target groups
    - Configure listeners and rules
    - Implement health checks

11. **Implementing CloudFront distributions**
    - Create CDN configurations
    - Set up origins and behaviors
    - Configure caching policies

12. **Building a complete 3-tier architecture**
    - Combine web, application, and database tiers
    - Implement proper networking between tiers
    - Configure security boundaries

13. **Setting up VPC peering**
    - Connect multiple VPCs
    - Configure route tables
    - Implement security group references

14. **Creating Lambda functions with API Gateway**
    - Deploy serverless functions
    - Configure API endpoints
    - Set up proper IAM permissions

15. **Implementing DynamoDB tables with integration**
    - Create NoSQL database tables
    - Configure capacity and scaling
    - Set up streams and triggers

16. **Deploying ECS tasks and services**
    - Define task definitions
    - Configure services and deployments
    - Set up container instances

### Advanced Level

17. **Building reusable Terraform modules**
    - Create parameterized modules
    - Implement module versioning
    - Publish and consume modules

18. **Implementing remote state with state locking**
    - Configure S3 backend
    - Set up DynamoDB locking
    - Manage state sharing

19. **Setting up CI/CD pipeline for Terraform**
    - Automate infrastructure deployments
    - Implement plan/apply workflows
    - Configure approval gates

20. **Multi-environment deployments (dev/staging/prod)**
    - Use workspaces or file structure
    - Implement environment-specific variables
    - Manage promotion between environments

21. **Implementing infrastructure testing with Terratest**
    - Write automated tests
    - Validate infrastructure behavior
    - Implement test-driven infrastructure

22. **Creating cross-account resources**
    - Set up resource sharing
    - Configure cross-account IAM roles
    - Implement security boundaries

23. **Setting up ECR repositories with lifecycle policies**
    - Create container registries
    - Configure image scanning
    - Implement cleanup policies

### Expert Level

24. **Deploying EKS clusters with node groups**
    - Provision Kubernetes control plane
    - Configure worker nodes
    - Set up authentication

25. **Implementing Kubernetes resources via Terraform**
    - Deploy Kubernetes manifests
    - Use Kubernetes provider
    - Manage cluster resources

26. **Setting up service mesh (like AWS App Mesh)**
    - Configure service discovery
    - Implement traffic routing
    - Set up observability

27. **Implementing multi-region disaster recovery**
    - Create cross-region replication
    - Configure failover mechanisms
    - Implement recovery procedures

28. **Creating compliance-as-code with policy enforcement**
    - Implement OPA/Sentinel policies
    - Configure policy checks
    - Enforce compliance standards

29. **Setting up private Terraform module registry**
    - Configure private registry
    - Implement module versioning
    - Set up access controls

30. **Implementing GitOps workflow with Terraform**
    - Set up declarative infrastructure
    - Configure drift detection
    - Implement automated reconciliation


# Beginner Level
01-s3-bucket
02-basic-vpc
03-ec2-instance
04-security-groups
05-iam-roles
06-route53-dns
07-cloudwatch-alarms

# Intermediate Level
08-rds-database
09-auto-scaling-groups
10-load-balancers
11-cloudfront-distribution
12-three-tier-architecture
13-vpc-peering
14-lambda-api-gateway
15-dynamodb-integration
16-ecs-deployment

# Advanced Level
17-reusable-modules
18-remote-state
19-cicd-pipeline
20-multi-environment
21-terratest-implementation
22-cross-account-resources
23-ecr-repositories

# Expert Level
24-eks-cluster
25-kubernetes-resources
26-service-mesh
27-multi-region-dr
28-compliance-as-code
29-private-module-registry
30-gitops-workflow

https://claude.ai/chat/210444cd-e741-4905-95ce-76d7fb637612

## How to Use This Repository

Each milestone is organized in its own directory with:
- README with specific requirements
- Sample Terraform code
- Testing and validation instructions
- Additional resources for learning

## Contribution

Feel free to contribute by submitting pull requests to improve examples, fix issues, or add additional learning resources.

## License

This project is licensed under the Apache License - see the LICENSE file for details.
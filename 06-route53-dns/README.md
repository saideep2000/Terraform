# 06 - Route53 DNS Configuration

This is the sixth milestone in the Terraform learning path. In this project, you will:
- Create public and private Route53 hosted zones
- Define various record types (A, CNAME, MX, TXT)
- Configure advanced routing policies (weighted, failover, latency, geolocation)

## Learning Objectives

- Understand DNS fundamentals and Route53 concepts
- Learn to create and manage hosted zones
- Configure different record types for various use cases
- Implement advanced routing policies
- Learn how DNS integrates with other AWS services


## DNS Configuration Overview

This project creates several types of DNS configurations:

### Hosted Zones

1. **Public Hosted Zone**: Accessible from the internet, used for public-facing services
2. **Private Hosted Zone**: Only accessible within a VPC, used for internal services

### Basic Record Types

1. **A Record**: Maps a domain directly to an IPv4 address
2. **CNAME Record**: Creates an alias from one domain to another
3. **MX Record**: Specifies mail servers for the domain
4. **TXT Record**: Stores text information, often used for verification
5. **Alias Record**: AWS-specific record that points to AWS resources

### Advanced Routing Policies

1. **Weighted Routing**: Distributes traffic based on assigned weights
   - Example: Blue/Green deployments with 80/20 traffic split

2. **Failover Routing**: Directs traffic based on health checks
   - Primary endpoint serves traffic when healthy
   - Secondary endpoint takes over when primary fails

3. **Latency-based Routing**: Routes users to the lowest-latency endpoint
   - Automatically sends users to the closest region

4. **Geolocation Routing**: Routes based on user geographic location
   - Different content or endpoints based on country or continent

## Important Considerations

### Working with Route53

- **Name Servers**: After creating a hosted zone, you need to update your domain registrar to use Route53's name servers
- **TTL (Time to Live)**: Determines how long records are cached; lower values enable faster changes but increase DNS query load
- **Health Checks**: Required for failover routing to detect endpoint health

### Connecting to Real Infrastructure

To connect these DNS records to actual infrastructure:

1. For EC2 instances, use their public IP addresses
2. For load balancers, use the alias record type with the LB's DNS name and zone ID
3. For private resources, ensure your VPC is associated with the private hosted zone

## Advanced Tasks

Once you're comfortable with the basic Route53 setup, try these enhancements:

1. Create multi-region DNS failover with health checks
2. Set up DNS for a blue/green deployment strategy
3. Implement DNSSEC for your domain
4. Create a Route53 Resolver endpoint to resolve hybrid DNS queries
5. Set up DNS for a multi-region active-active application architecture

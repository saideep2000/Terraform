variable "aws_region" {
  description = "AWS region where the EC2 instance will be created"
  type        = string
  default     = "us-east-2"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "terraform-demo-instance"
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "ssh_allowed_cidr" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Note: For production, restrict to your IP
}

variable "key_pair_name" {
  description = "Name of the key pair for SSH access"
  type        = string
  default     = ""  # If left empty, no key pair will be used
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
  default     = "~/.ssh/my-terraform-key-pair.pem"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be created (optional)"
  type        = string
  default     = ""  # If left empty, default subnet will be used
}
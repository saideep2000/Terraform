output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "load_balancer_sg_id" {
  description = "The ID of the load balancer security group"
  value       = aws_security_group.load_balancer_sg.id
}

output "web_server_sg_id" {
  description = "The ID of the web server security group"
  value       = aws_security_group.web_server_sg.id
}

output "app_server_sg_id" {
  description = "The ID of the application server security group"
  value       = aws_security_group.app_server_sg.id
}

output "database_sg_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.database_sg.id
}

output "bastion_sg_id" {
  description = "The ID of the bastion host security group"
  value       = aws_security_group.bastion_sg.id
}

output "security_group_dependencies" {
  description = "Map showing security group dependencies"
  value = {
    "load_balancer" = "Internet"
    "web_server"    = aws_security_group.load_balancer_sg.name
    "app_server"    = aws_security_group.web_server_sg.name
    "database"      = aws_security_group.app_server_sg.name
    "bastion"       = "SSH from allowed IPs only"
  }
}
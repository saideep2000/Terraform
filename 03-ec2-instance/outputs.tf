output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "ami_id" {
  description = "ID of the AMI used"
  value       = data.aws_ami.amazon_linux.id
}

output "ami_name" {
  description = "Name of the AMI used"
  value       = data.aws_ami.amazon_linux.name
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${var.private_key_path} ec2-user@${aws_instance.web_server.public_dns}"
}
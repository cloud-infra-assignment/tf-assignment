output "instance_id" {
  value       = aws_instance.web.id
  description = "EC2 instance ID"
}

output "private_ip" {
  value       = aws_instance.web.private_ip
  description = "Private IP address of EC2 in private subnet"
}

output "security_group_id" {
  value       = aws_security_group.web.id
  description = "Security group ID for EC2"
}

output "ami_id" {
  value       = data.aws_ami.amazon_linux_2.id
  description = "AMI ID used for the instance"
}


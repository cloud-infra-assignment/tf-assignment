output "nlb_dns" {
  value       = module.nlb.nlb_dns_name
  description = "Network Load Balancer DNS name - use this to access the web server"
}

output "ec2_private_ip" {
  value       = module.web_server.private_ip
  description = "EC2 private IP (not directly accessible - only through NLB)"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "Public subnet ID (for NLB)"
}

output "private_subnet_id" {
  value       = module.vpc.private_subnet_id
  description = "Private subnet ID (for EC2)"
}

output "ec2_instance_id" {
  value       = module.web_server.instance_id
  description = "EC2 instance ID"
}

output "nat_gateway_id" {
  value       = module.vpc.nat_gateway_id
  description = "NAT Gateway ID (for EC2 outbound traffic)"
}


output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "Public subnet ID (for NLB)"
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
  description = "Private subnet ID (for EC2)"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "Internet Gateway ID"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.main.id
  description = "NAT Gateway ID"
}


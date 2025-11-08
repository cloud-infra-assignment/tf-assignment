output "nlb_dns_name" {
  value       = aws_lb.nlb.dns_name
  description = "DNS name of the Network Load Balancer"
}

output "nlb_arn" {
  value       = aws_lb.nlb.arn
  description = "ARN of the Network Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.web.arn
  description = "ARN of the target group"
}

output "nlb_security_group_id" {
  value       = aws_security_group.nlb.id
  description = "Security group ID for NLB"
}


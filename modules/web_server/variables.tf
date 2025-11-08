variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "proxy_ip" {
  description = "National Proxy IP address"
  type        = string
}

variable "public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "target_group_arn" {
  description = "ARN of the NLB target group"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "nlb_subnet_cidr" {
  description = "CIDR block of the public subnet where the NLB resides (for health checks)"
  type        = string
}


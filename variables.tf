variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "proxy_ip" {
  description = "National Proxy IP address"
  type        = string
  default     = "91.231.246.50/32"
}

variable "public_key" {
  description = "SSH public key for EC2 access"
  type        = string
  sensitive   = true
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIN16ABpKKn3DTBXDYcKImSZ+NQbcWC7Bmlp/YqbD+pvPV9HEkYS7cqpNl4BoG4O16WqcXEGdQuhIMkpNvozvs6lPWdQF5Ch01M/hVHlkvVdDXk1Dnc9/eb29aYHuH+YYNHVe7csfTV7BhkA453m8efL+xAAoujRYzdAuKXI7SpxK4zGqh0Sov3TJagTVM2Ck9+vC5shi+weUYhlDf2sERnFeItz3CD4Bon7XGDa1GbRSbVZI80E+DNeObdWpOlKPGwGjZylHNNUEXMml6wt92mI3/PDFBK2/ntrWd/imFwyULZ2zn5A7HYxcdKAxba6ybvmyyMo4rYe7JzSOW5tmeMTSejr2e+5dVA7ZKL53ka8mBu3Nco4xawTAIwGOaJ61pmRRvvkOKSN0y7GW/lDXfMa9NQ4E4uG4i4WMoKlPXrjVhscWoQnmRY1mQYnjrhocE7zEau3KgCIC/m9f9ZKHwhAsy/8i2xGpBAn8IBH4QbuN7/HleveT3JHC51ZhbQuuh9AFr6nSqxgo1MIChvomTWCPZGqFtsQkODByedf8LE0MUs0on1j4/npGeiRUUmjwHaK15QeLRHb9zw1LDQ6agur8fW27vGmRriWRUv8EXk0E/VRSqu0szjl3ERRoG8iwJFTdmNr87EIBVeUnEzbf39gvzBnyheKun4DmK0FEx1w== tf-assignment"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "tf-assignment"
  }
}


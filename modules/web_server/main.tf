# Data source to find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "tf-assignment"
  public_key = var.public_key

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-deployer-key"
    }
  )
}

# Security Group for EC2
# NLB preserves client source IP, so we can filter by the proxy IP directly
resource "aws_security_group" "web" {
  vpc_id      = var.vpc_id
  description = "Security group for web server EC2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.proxy_ip]
    description = "Allow HTTP from Leumi proxy only"
  }

  # Allow NLB health checks from the NLB's subnet only
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.nlb_subnet_cidr]
    description = "Allow NLB health checks"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-web-sg"
    }
  )
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.deployer.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Web Server is Running</h1>" > /var/www/html/index.html
  EOF
  )

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-web-server"
    }
  )
}

# Register EC2 with NLB
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web.id
  port             = 80
}


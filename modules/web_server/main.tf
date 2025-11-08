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
resource "aws_security_group" "web" {
  vpc_id      = var.vpc_id
  description = "Security group for web server EC2"

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

# Allow traffic from NLB to EC2 only (EC2 is private, NLB is public bridge)
resource "aws_security_group_rule" "nlb_to_ec2" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = var.nlb_security_group_id
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


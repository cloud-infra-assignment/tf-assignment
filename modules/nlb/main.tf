# Security Group for NLB
resource "aws_security_group" "nlb" {
  vpc_id      = var.vpc_id
  description = "Security group for Network Load Balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.proxy_ip]
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
      Name = "${var.environment}-nlb-sg"
    }
  )
}

# Network Load Balancer
resource "aws_lb" "nlb" {
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.subnet_id]
  security_groups    = [aws_security_group.nlb.id]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-nlb"
    }
  )
}

# Target Group
resource "aws_lb_target_group" "web" {
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-tg"
    }
  )
}

# NLB Listener
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}


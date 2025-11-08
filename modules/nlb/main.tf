# Elastic IP for NLB (fixed public IP as required)
resource "aws_eip" "nlb" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-nlb-eip"
    }
  )
}

# Network Load Balancer
# Note: NLBs don't support security groups. IP filtering must be done via:
# 1. NACLs on the subnet level, or
# 2. Security groups on the target EC2 (but client IP is preserved)
resource "aws_lb" "nlb" {
  internal           = false
  load_balancer_type = "network"

  # Use subnet_mapping to assign the Elastic IP
  subnet_mapping {
    subnet_id     = var.subnet_id
    allocation_id = aws_eip.nlb.id
  }

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

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    port                = 80
    protocol            = "TCP"
  }

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


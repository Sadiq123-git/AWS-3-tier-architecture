# Create an Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "newalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id] # Using Web Tier SG
  subnets            = [
    aws_subnet.public_subnet.id,
    aws_subnet.private_subnet.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "newalb"
  }
}

# Create a Target Group for Web EC2 instances
resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.newvpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "web-target-group"
  }
}

# Create a Listener for ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

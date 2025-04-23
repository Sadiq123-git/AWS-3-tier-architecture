# Web Tier Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for Web Tier (ALB + Web EC2s)"
  vpc_id      = aws_vpc.newvpc.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere (Optional, if you want SSL later)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH (Optional: Restrict it in production)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# App Tier Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for App Tier (App EC2s)"
  vpc_id      = aws_vpc.newvpc.id

  ingress {
    description = "Allow traffic from Web Tier"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

# DB Tier Security Group
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Security group for Database Tier (RDS)"
  vpc_id      = aws_vpc.newvpc.id

  ingress {
    description = "Allow MySQL traffic from App Tier"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

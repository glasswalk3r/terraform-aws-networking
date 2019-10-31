resource "aws_security_group" "ec2_public" {
  vpc_id      = aws_vpc.main.id
  name        = "ec2-public"
  description = "SG for public EC2 instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.ip.cidr]
    description = "SSH for admin"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(module.common_tags.tags, { "Name" = "ec2-public" })
}

resource "aws_security_group" "ec2_private" {
  vpc_id      = aws_vpc.main.id
  name        = "ec2-private"
  description = "SG for private EC2 instances"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_public.id]
    description     = "SSH for admin"
    self            = true
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.ec2_public.id]
    description     = "Ping for admin"
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(module.common_tags.tags, { "Name" = "ec2-private" })
}

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

  tags = module.common_tags.tags
}

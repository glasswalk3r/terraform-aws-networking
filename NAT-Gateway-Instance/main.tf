module "common_tags" {
  source       = "../modules/tags"
  environment  = var.environment
  project_name = var.project_name
}

resource "aws_security_group" "ec2_nat" {
  vpc_id      = data.aws_vpc.main.id
  name        = "ec2_nat"
  description = "SG for EC2 NAT instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.main_public.cidr_block]
    description = "SSH for admin"
    self        = true
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    self        = false
    cidr_blocks = [data.aws_subnet.main_private.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    self        = false
    cidr_blocks = [data.aws_subnet.main_private.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [data.aws_subnet.main_private.cidr_block]
    description = "Ping for admin"
    self        = false
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(module.common_tags.tags, { "Name" = "ec2-nat-sg" })
}

module "ec2_nat" {
  source                 = "../modules/ec2"
  use_public_ip          = true
  subnet_id              = data.aws_subnet.main_public.id
  vpc_security_group_ids = [aws_security_group.ec2_nat.id]
  name                   = "EC2-NAT"
  environment            = var.environment
  ec2_ami_id             = data.aws_ami.aws_ec2_ami.id
  additional_cmd         = var.nat_cmd
  # see the creation of the key pair in the VPC project
  ssh_pair_name     = "standard-ec2-instance-key"
  project_name      = var.project_name
  do_src_dest_check = false
}

resource "aws_route" "nat_gw" {
  route_table_id         = data.aws_route_table.main_private.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.ec2_nat.id
}

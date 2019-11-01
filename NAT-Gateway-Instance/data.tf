data "aws_ami" "aws_ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-*-x86_64-ebs"]
  }

  filter {
    name   = "is-public"
    values = [true]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "hypervisor"
    values = ["xen"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"]
}

data "aws_vpc" "main" {
  tags = {
    "Name" = "vpc-publicprivatesubnets"
  }
  cidr_block = "10.0.0.0/16"
  state      = "available"
}

data "aws_subnet" "main_public" {
  cidr_block = "10.0.0.0/24"
  state      = "available"
  tags = {
    "Name" = "Public Subnet A"
  }
  vpc_id = data.aws_vpc.main.id
}

data "aws_subnet" "main_private" {
  cidr_block = "10.0.1.0/24"
  state      = "available"
  tags = {
    "Name" = "Private Subnet B"
  }
  vpc_id = data.aws_vpc.main.id
}

data "aws_route_table" "main_private" {
  subnet_id = data.aws_subnet.main_private.id
}

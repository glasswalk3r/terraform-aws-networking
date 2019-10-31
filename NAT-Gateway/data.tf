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

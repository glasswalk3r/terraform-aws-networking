resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"
  enable_classiclink   = "false"
  tags                 = merge(module.common_tags.tags, { "Name" = module.common_tags.tags["project_name"] })
}

# Subnets
resource "aws_subnet" "main_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"
  tags                    = merge(module.common_tags.tags, { "Name" = "Public Subnet A" })
}

resource "aws_subnet" "main_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}b"
  tags                    = merge(module.common_tags.tags, { "Name" = "Private Subnet B" })
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(module.common_tags.tags, { "Name" = module.common_tags.tags["project_name"] })
}

# route tables
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = merge(module.common_tags.tags, { "Name" = "main public" })
}

# route tables
resource "aws_route_table" "main_private" {
  vpc_id = aws_vpc.main.id
  tags   = merge(module.common_tags.tags, { "Name" = "main private" })
}

# route associations
resource "aws_route_table_association" "main_public_route_assoc" {
  subnet_id      = aws_subnet.main_public.id
  route_table_id = aws_route_table.main_public.id
}

resource "aws_route_table_association" "main_private_route_assoc" {
  subnet_id      = aws_subnet.main_private.id
  route_table_id = aws_route_table.main_private.id
}

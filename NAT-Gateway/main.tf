module "common_tags" {
  source       = "../modules/tags"
  environment  = var.environment
  project_name = var.project_name
}

resource "aws_eip" "nat_gw_eip" {
  vpc  = true
  tags = merge(module.common_tags.tags, { "Name" = "private-nat" })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = data.aws_subnet.main_public.id
  tags          = merge(module.common_tags.tags, { "Name" = "private-nat" })
}

resource "aws_route" "nat_gw" {
  route_table_id         = data.aws_route_table.main_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

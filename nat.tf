locals {
  nat_count = var.public_ip_on_launch ? 0 : 1
}

resource "aws_eip" "nat_ip" {
  count = local.nat_count
  tags  = var.tags
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = cidrsubnet(var.cidr_block, local.netbits, 1)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  count                   = local.nat_count
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_ip[0].id
  subnet_id     = aws_subnet.public_subnet[0].id
  count         = local.nat_count
  tags          = var.tags
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  count  = local.nat_count
  tags   = var.tags
}

resource "aws_route" "route_to_default_gw" {
  route_table_id         = aws_route_table.public_route_table[0].id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
  count                  = local.nat_count
}

resource "aws_route_table_association" "pub_route_table_association" {
  route_table_id = aws_route_table.public_route_table[0].id
  subnet_id      = aws_subnet.public_subnet[0].id
  count          = local.nat_count
}


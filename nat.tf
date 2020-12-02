
resource "aws_eip" "nat_ip" {
  count = var.public_ip_on_launch ? 0:1
  tags  = var.tags
}

resource "aws_subnet" "public_subnet" {
  for_each = var.public_ip_on_launch ? toset([]):toset(data.aws_availability_zones.available.names)
  cidr_block              = cidrsubnet(var.cidr_block, var.netbit_masks==0?local.netbits:var.netbit_masks,index(data.aws_availability_zones.available.names,each.value)+var.start_network)
  vpc_id                  = aws_vpc.this.id
}

resource "aws_nat_gateway" "nat_gw" {
  count = var.public_ip_on_launch ? 0:1
  allocation_id = aws_eip.nat_ip[0].id
  subnet_id     = element([for sub in aws_subnet.public_subnet: sub.id],0)
  tags          = var.tags
}

resource "aws_route_table" "public_route_table" {
  count = var.public_ip_on_launch ? 0:1
  vpc_id = aws_vpc.this.id
  tags   = var.tags
}

resource "aws_route" "route_to_default_gw" {
  count = var.public_ip_on_launch ? 0:1
  route_table_id         = aws_route_table.public_route_table[0].id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pub_route_table_association" {
  for_each = var.public_ip_on_launch ? toset([]):toset(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.public_route_table[0].id
  subnet_id      = aws_subnet.public_subnet[each.value].id
}


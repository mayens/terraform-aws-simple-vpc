terraform {
  required_version = ">= 0.12"
}

locals {
  netbits = var.public_ip_on_launch ? ceil(log(length(data.aws_availability_zones.available.names), 2)) : ceil(
    log(2 + length(data.aws_availability_zones.available.names), 2),
  )
  netbit_delta = var.public_ip_on_launch ? 1 : 2
}

##########################
##VPC Declaration
##########################
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags                 = merge(var.vpc_tags, var.tags)
}

##########################
## Subnet Declaration, One by avz
##########################
resource "aws_subnet" "this" {
  cidr_block = cidrsubnet(
    var.cidr_block,
    local.netbits,
    count.index + local.netbit_delta,
  )
  vpc_id                  = aws_vpc.this.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = var.public_ip_on_launch
  tags                    = var.tags
}

##########################
##Internet Gateway
##########################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = var.tags
}

##########################
##Route Table
##########################
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route" "default_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.public_ip_on_launch ? aws_internet_gateway.this.id : aws_nat_gateway.nat_gw[0].id
  route_table_id         = aws_route_table.this.id
  lifecycle {
    ignore_changes = [gateway_id]
  }
}

##########################
##Associate Route table to subnet
##########################
resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this.*.id[count.index]
  count          = length(aws_subnet.this)
}


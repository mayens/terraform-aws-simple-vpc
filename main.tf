terraform {
  required_version = ">= 0.11.8" # tested on this version
}

locals {
  netbits = "${ceil(log(length(data.aws_availability_zones.available.names),2))}"
}

##########################
##VPC Declaration
##########################
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true


  tags = "${merge(var.vpc_tags,var.tags)}"
}

##########################
## Subnet Declaration, One by avz
##########################
resource "aws_subnet" "this" {
  cidr_block              = "${cidrsubnet(var.cidr_block,local.netbits,count.index+1)}"
  vpc_id                  = "${aws_vpc.this.id}"
  availability_zone       = "${element(data.aws_availability_zones.available.names ,count.index)}"
  count                   = "${length(data.aws_availability_zones.available.names)}"
  map_public_ip_on_launch = "${var.public_ip_on_launch}"
  tags                    = "${var.tags}"
}

##########################
##Internet Gateway
##########################
resource "aws_internet_gateway" "this" {
  vpc_id  = "${aws_vpc.this.id}"
  tags    = "${var.tags}"
}

##########################
##Route Table
##########################
resource "aws_route_table" "this" {
  vpc_id = "${aws_vpc.this.id}"

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }
  tags = "${var.tags}"
}

##########################
##Associate Route table to subnet
##########################
resource "aws_route_table_association" "this" {
  route_table_id  = "${aws_route_table.this.id}"
  subnet_id       = "${element(aws_subnet.this.*.id,count.index)}"
  count           = "${aws_subnet.this.count}"
}

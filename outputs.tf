output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnets_id" {
  description = "subnets"
  value = aws_subnet.this.*.id
}

output "route_table_id" {
  value = aws_route_table.this.id
}

output "nat_ip" {
  value = join("", aws_eip.nat_ip.*.public_ip)
}


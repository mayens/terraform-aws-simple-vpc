output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnets_id" {
  description = "subnets"
  value = [for subnet in aws_subnet.this:subnet.id]
}

output "pub_subnets" {
  value = [for subnet in aws_subnet.public_subnet:subnet.id]
}
output "route_table_id" {
  value = aws_route_table.this.id
}

output "nat_ip" {
  value = [for eip in aws_eip.nat_ip:eip.public_ip]
}


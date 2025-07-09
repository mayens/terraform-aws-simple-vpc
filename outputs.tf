output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnets_id" {
  description = "Private subnets ID"
  value       = [for subnet in aws_subnet.this :subnet.id]
}

output "pub_subnets" {
  description = "public subnets ID"
  value = [for subnet in aws_subnet.public_subnet :subnet.id]
}

output "default_route_table_id" {
  description = "Route table ID"
  value = aws_route_table.this.id
}

output "route_table_private_networks" {
  description = "private Route tables id"
  value = [for rt in aws_route_table.nat_routing : rt.id ]
}

output "nat_ip" {
  description = "Nats ip"
  value = [for eip in aws_eip.nat_ip :eip.public_ip]
}
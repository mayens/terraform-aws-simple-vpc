variable "subnetbits" {
  description = "netbits to use"
  default = "3"
}

variable "cidr_block" {
  description = "cidr block of subnet"
  default = "192.168.1.0/24"
}

variable "tags" {
  description = "A map of tags to add to resources"
  type = "map"
  default = {
    Name = "Terraform VPC_elts"
  }
}
variable "vpc_tags" {
  description = "A map of tags to add to vpc only"
  type = "map"
  default = {
    Name = "Terraform VPC"
  }
}
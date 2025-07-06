# Automated terraform vpc creation module

> Terraform module intended to create vpc on aws with one subnet by availability zone.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_main_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route_to_default_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.nat_routing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.pub_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | cidr block of subnet | `string` | `"192.168.1.0/24"` | no |
| <a name="input_netbit_masks"></a> [netbit\_masks](#input\_netbit\_masks) | override default netbits masks | `number` | `0` | no |
| <a name="input_public_ip_on_launch"></a> [public\_ip\_on\_launch](#input\_public\_ip\_on\_launch) | Map public ip by default on launched resources | `string` | `true` | no |
| <a name="input_resilient_nat_gw"></a> [resilient\_nat\_gw](#input\_resilient\_nat\_gw) | Use one net GW per AZ | `bool` | `false` | no |
| <a name="input_start_network"></a> [start\_network](#input\_start\_network) | Num of first network | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to resources | `map(string)` | <pre>{<br/>  "Name": "Terraform VPC_elts"<br/>}</pre> | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | A map of tags to add to vpc only | `map(string)` | <pre>{<br/>  "Name": "Terraform VPC"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_ip"></a> [nat\_ip](#output\_nat\_ip) | Nats ip |
| <a name="output_pub_subnets"></a> [pub\_subnets](#output\_pub\_subnets) | public subnets ID |
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | Route table ID |
| <a name="output_route_table_pub"></a> [route\_table\_pub](#output\_route\_table\_pub) | Public Route tables id |
| <a name="output_subnets_id"></a> [subnets\_id](#output\_subnets\_id) | subnets ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |

mock_provider "aws" {
  mock_data "aws_availability_zones" {
    defaults = {
          names = ["a","b","c"]
    }
  }
}
test {
  parallel = true
}

run "default_configuration" {
  assert {
    condition = length(output.subnets_id)==length(data.aws_availability_zones.available.names)
    error_message= "Bad number of subnets on default configuration."
  }
}

run "pn_configuration" {
  variables {
    public_ip_on_launch = false
    resilient_nat_gw= true
  }
  assert {
    condition = length(data.aws_availability_zones.available.names)==length(output.pub_subnets)
    error_message= "Bad number of subnets on Private Network configuration."

  }
  assert {
    condition = length(data.aws_availability_zones.available.names)==length(output.nat_ip)
    error_message= "Bad number of nat Gateway."
  }
}
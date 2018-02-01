#--------------------------------------------------------
# current environment
#--------------------------------------------------------
variable "env" { }

#--------------------------------------------------------
# vpc
#--------------------------------------------------------
variable "vpc_config" {
  default = {
    cidr_block                       = "12.0.0.0/16"
    instance_tenancy                 = "default"
    enable_dns_support               = true
    enable_dns_hostnames             = true
    assign_generated_ipv6_cidr_block = true
    tags_Name                        = "my_vpc"

  }
}

variable "subnet_public_a_config" {
  default = {
    cidr_block                      = "12.0.0.0/24"
    availability_zone               = "ap-northeast-1a"
    tags_Name                       = "my_AZ_a"
  }
}

variable "subnet_public_c_config" {
  default = {
    cidr_block                      = "12.0.1.0/24"
    availability_zone               = "ap-northeast-1c"
    tags_Name                       = "my_AZ_c"

  }
}

variable "route_table_public_route_config" {
  default = {
    route_cidr_block                = "0.0.0.0/0"
  }
}

variable "internet_gateway" {
  default = {
    tags_Name                       = "my-Gateway"
  }
}

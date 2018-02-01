resource "aws_vpc" "my_vpc" {
  cidr_block                          = "${lookup(var.vpc_config, "cidr_block")}"
  instance_tenancy                    = "${lookup(var.vpc_config, "instance_tenancy")}"
  enable_dns_support                  = "${lookup(var.vpc_config, "enable_dns_support")}"
  enable_dns_hostnames                = "${lookup(var.vpc_config, "enable_dns_hostnames")}"
  assign_generated_ipv6_cidr_block    = "${lookup(var.vpc_config, "assign_generated_ipv6_cidr_block")}"
  tags {
    Name                              = "${lookup(var.vpc_config, "tags_Name")}"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                              = "${aws_vpc.my_vpc.id}"
  cidr_block                          = "${lookup(var.subnet_public_a_config, "cidr_block")}"
  availability_zone                   = "${lookup(var.subnet_public_a_config, "availability_zone")}"
  tags {
    Name                              = "${lookup(var.subnet_public_a_config, "tags_Name")}"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                              = "${aws_vpc.my_vpc.id}"
  cidr_block                          = "${lookup(var.subnet_public_c_config, "cidr_block")}"
  availability_zone                   = "${lookup(var.subnet_public_c_config, "availability_zone")}"
  tags {
    Name                              = "${lookup(var.subnet_public_c_config, "tags_Name")}"
  }
}

resource "aws_internet_gateway" "my_GW" {
  vpc_id                              = "${aws_vpc.my_vpc.id}"
  tags {
    Name                              = "${lookup(var.internet_gateway, "tags_Name")}"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id                              = "${aws_vpc.my_vpc.id}"
  route {
    cidr_block                        = "${lookup(var.route_table_public_route_config, "route_cidr_block")}"
    gateway_id                        = "${aws_internet_gateway.my_GW.id}"
  }
}

resource "aws_route_table_association" "public_a"{
  subnet_id                           = "${aws_subnet.public_a.id}"
  route_table_id                      = "${aws_route_table.public_route.id}"
}

resource "aws_route_table_association" "public_c"{
  subnet_id                           = "${aws_subnet.public_c.id}"
  route_table_id                      = "${aws_route_table.public_route.id}"
}

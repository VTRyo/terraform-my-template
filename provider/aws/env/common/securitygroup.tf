##--------------------------------------------------------
## security group (my-MAIL)
##--------------------------------------------------------
resource "aws_security_group" "my-mail" {
  name                      = "my-mail"
  description               = "MAIL port"
  vpc_id                    = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port               = 110
    to_port                 = 110
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  ingress {
    from_port               = 110
    to_port                 = 110
    protocol                = "tcp"
    ipv6_cidr_blocks        = ["::/0"]
  }

  ingress {
    from_port               = 25
    to_port                 = 25
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  ingress {
    from_port               = 25
    to_port                 = 25
    protocol                = "tcp"
    ipv6_cidr_blocks        = ["::/0"]
  }

  ingress {
    from_port               = 465
    to_port                 = 465
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  ingress {
    from_port               = 465
    to_port                 = 465
    protocol                = "tcp"
    ipv6_cidr_blocks        = ["::/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    ipv6_cidr_blocks        = ["::/0"]
  }

  tags {
    Name                    = "my-mail"
  }
}

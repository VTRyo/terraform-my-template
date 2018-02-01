output "vpc_id" {
  value = "${aws_vpc.my_vpc.id}"
}

output "subnet_public_a_id" {
  value = "${aws_subnet.public_a.id}"
}

output "subnet_public_c_id" {
  value = "${aws_subnet.public_c.id}"
}

output "security_group_mail" {
  value = "${aws_security_group.my-mail.id}"
}

output "env" {
   value = "${var.env}"
}

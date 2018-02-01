resource "aws_instance" "my-server" {
  ami                      = "${lookup(var.ec2_my_config, "ami")}"
  instance_type            = "${lookup(var.ec2_my_config, "instance_type")}"
  disable_api_termination  = "${lookup(var.ec2_my_config, "disable_api_termination")}"
  key_name                 = "${lookup(var.ec2_my_config, "instance_key")}"
  vpc_security_group_ids   = ["${data.terraform_remote_state.common.security_group_mail}"]
  subnet_id                = "${data.terraform_remote_state.common.subnet_public_a_id}"
  root_block_device        = {
    volume_type            = "gp2"
    volume_size            = "30"
  }
  tags {
    Name                   = "${var.env}-my-${format("server%02d", count.index + 1)}"
  }
}

resource "aws_eip" "dev-my-server" {
  instance                 = "${aws_instance.my-server.id}"
  vpc                      = true
  tags {
    Name                   = "${var.env}-my-${format("server%02d", count.index + 1)}"
  }
}

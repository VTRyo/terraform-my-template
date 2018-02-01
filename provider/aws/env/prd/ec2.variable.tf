#--------------------------------------------------------
# current environment
#--------------------------------------------------------
variable "env" { }

#--------------------------------------------------------
# ec2
#--------------------------------------------------------

variable "ec2_my_config" {
  default = {
    ami                             = "ami-4af5022c"
    instance_type                   = "t2.micro"
    instance_key                    = "infra"
    disable_api_termination         = true
    root_block_device_volume_type   = "gp2"
    root_block_device_volume_size   = "30"
  }
}

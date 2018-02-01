provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-sample"
    key = "prd/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "common" {
  backend = "s3"
  config {
    bucket = "terraform-sample"
    key    = "common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-sample"
    key = "common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

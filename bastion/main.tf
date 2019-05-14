# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-test-seoul"
    key    = "bastion.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "bastion" {
  source = "git::https://github.com/opsnow-tools/terraform-aws-bastion.git//modules/bastion"

  region = "ap-northeast-2"
  city   = "SEOUL"
  stage  = "JANG"
  name   = "TEST"
  suffix = "BASTION"

  vpc_id = "vpc-06a42e46c7e42c99a"

  subnet_id = "subnet-0b7ca37aa0ae3f539"

  type = "t2.nano"

  key_name = "SEOUL-JANG-TEST-BASTION"

  allow_ip_address = [
    "0.0.0.0/0",
  ]
}

output "name" {
  value = "${module.bastion.name}"
}

output "key_name" {
  value = "${module.bastion.key_name}"
}

output "public_ip" {
  value = "${module.bastion.public_ip}"
}

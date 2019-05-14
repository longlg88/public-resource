terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-test-seoul"
    key = "vpc.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc"{
  source = "git::https://github.com/opsnow-tools/terraform-aws-vpc.git//modules/vpc"

  region = "ap-northeast-2"
  city = "SEOUL"
  stage = "JANG"
  name = "TEST"

  vpc_cidr = "10.10.0.0/16"
  public_subnet_enable = true
  public_subnet_newbits = 8
  public_subnet_netnum = 25

  private_subnet_enable = true
  private_subnet_newbits = 8
  private_subnet_netnum = 27

  single_nat_gateway = false
  tags = "${
    map(
      "kubernetes.io/cluster/seoul-jang-test-kops", "shared"
    )
  }"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_cidr}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "private_subnet_cidr" {
  value = "${module.vpc.private_subnet_cidr}"
}

output "nat_ip" {
  value = "${module.vpc.nat_ip}"
}

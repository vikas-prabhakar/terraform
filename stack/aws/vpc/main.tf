terraform {
  backend "s3" {
    bucket          = "statelocking"
    key             = "prod/vpc/terraform.tfstate"
    region          = "ap-south-1"
    dynamodb_table  = "terraformlock"
  }
}

module "vpc" {
  source              = "git::git@github.com:vikas-prabhakar/terraform-vpc.git?ref=v0.0.1"
  name                = "stack"
  environment         = "prod"
  vpc_cidr            = "10.0.0.0/18"
  profile             = "default"
}

module "internet_gateway" {
  source              = "git::git@github.com:vikas-prabhakar/terraform-internetgateway.git?ref=v0.0.1"
  vpc_id              = "${module.vpc.vpc_id}"
  name                = "stack"
  environment         = "prod"
  profile             = "default"
}

output aws_vpc_id {
  value = "${module.vpc.vpc_id}"
}

output aws_vpc_cidr {
  value = "${module.vpc.vpc_cidr}"
}

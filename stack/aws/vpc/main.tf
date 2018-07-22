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

module "external_subnet" {
  source              = "git::git@github.com:vikas-prabhakar/terraform-publicsubnet.git?ref=v1.0.1"
  vpc_id              = "${module.vpc.vpc_id}"
  name                = "stack"
  environment         = "prod"
  profile             = "default"

  public_subnets {
     "10.0.1.0/24"   = "public"
     "10.0.2.0/24" = "public"
  }

}

output aws_vpc_id {
  value = "${module.vpc.vpc_id}"
}

output aws_vpc_cidr {
  value = "${module.vpc.vpc_cidr}"
}

output aws_igw_id {
  value = "${module.external_subnet.igw_id}"
}

output aws_public_id {
  value = "${module.external_subnet.subnet_id}"
}

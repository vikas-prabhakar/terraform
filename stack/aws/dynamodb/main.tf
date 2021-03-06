module "s3" {
  source              = "git::git@github.com:vikas-prabhakar/terraform-s3.git?ref=v0.0.4"
  bucket_name	      = "statelocking"
  versioning_enabled  = "true"
  profile	      = "default"
}

module "dynamodb" {
  source              = "git::git@github.com:vikas-prabhakar/terraform-dynamodb.git?ref=v0.0.1"
  profile             = "default"
  dynamodb_name       = "terraformlock"
}

output aws_s3_statelock_bucket {
  value = "${module.s3.s3_bucket_name}"
}

output aws_dynamodb {
  value = "${module.dynamodb.dynamodb_output}"
}

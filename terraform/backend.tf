provider "aws" {
  region = "us-east-1"

  ignore_tags {
    key_prefixes = ["AutoTag_"]
  }
}
terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "573626210569-tf-remote-state"
    dynamodb_table = "tf-state-lock"
    key            = "git://github.com/amankaurgandhi/codecov-demo.git"
    region         = "us-east-1"
    profile        = "573626210569"
  }
}

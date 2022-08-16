provider "aws" {
  region = "us-east-1"

  ignore_tags {
    key_prefixes = ["AutoTag_"]
  }
}

terraform {
  backend "s3" {
    bucket         = "573626210569-tf-remote-state"
    key            = "git://github.com/amankaurgandhi/codecov-demo.git"
    region         = "us-east-1"
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  # Invalid provider URL that will cause an error
  hostname = "invalid.aws.amazon.com"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket-123456"
} 
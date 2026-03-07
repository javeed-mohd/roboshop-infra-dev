terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0" # TERRAFORM AWS Provider Version
    }
  }

  backend "s3" {
    bucket  = "remote-state-aws-devops-dev" # Replace with your unique bucket name
    key     = "roboshop-dev-sg" # .tfstate is optional (This key should be different for each file)
    region  = "us-east-1"
    encrypt = true
    use_lockfile   = true
  }
}

provider "aws" {
  region = "us-east-1" # Configuration options
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"
}
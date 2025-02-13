terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "workspacetrfm33"
    key            = "workspace_key"
    region         = "us-east-1"
    dynamodb_table = "workspacedb"
  }
}

provider "aws" {
  region = "us-east-1"
}

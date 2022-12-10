### AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_auth.access_key
  secret_key = var.aws_auth.secret_key
  default_tags {
    tags = {
      ConfigBy    = "TF: terraform-cloud-demo-${var.env}"
      Repo        = "https://github.com/charmon79/terraform-cloud-demo"
      Environment = "${var.env}"
      Purpose     = "Demonstrate managing infrastructure using Terraform Cloud"
    }
  }
}

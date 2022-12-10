data "aws_ebs_default_kms_key" "current" {}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet" "subnet_aza" {
  id = var.subnet_id
}

### locals
locals {
  azs = {
    a = "${var.aws_region}a"
    b = "${var.aws_region}b"
    c = "${var.aws_region}c"
  }
}

### variables
variable "aws_auth" {
  type = object(
    {
      access_key = string
      secret_key = string
    }
  )
}

variable "aws_region" {
  type = string
}

variable "env" {
  type    = string
  default = "dev"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

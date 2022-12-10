# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/docs/backends/types/remote.html
terraform {
  backend "remote" {
    organization = "charmon-demo"

    workspaces {
      prefix = "terraform-cloud-demo-"
    }
  }

  required_version = ">= 1.3.6"
}

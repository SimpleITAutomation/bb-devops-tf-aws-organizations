#
# Providers
#
provider "aws" {
    region = var.region
    profile = var.profile
    version = "~> 2.24"
}

#
# Backend Config (partial)
#
terraform {
    required_version = ">= 0.12.6"

    backend "s3" {
        key = "root/organization/terraform.tfstate"
    }
}
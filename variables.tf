#
# AWS Provider Settings
#
variable "region" {
  description = "AWS Region"
}
variable "profile" {
  description = "AWS Profile"
}

#
# Backend Variables -- because TF12 will not allow you to omit these :(
#
variable "bucket" {}
variable "encrypt" {}
variable "dynamodb_table" {}
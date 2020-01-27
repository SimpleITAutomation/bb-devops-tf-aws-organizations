#
# AWS Provider Settings
#
variable "region" {
  description = "AWS Region"
}

variable "profile" {
  description = "AWS Profile"
}

#===========================================#
# Project Variables                         #
#===========================================#
variable "project" {
  description = "Project Name"
}

variable "project_long" {
  description = "Project Long Name"
}

variable "environment" {
  description = "Environment Name"
  default     = "dev"
}

#
# Backend Variables -- because TF12 will not allow you to omit these :(
#
variable "bucket" {}
variable "encrypt" {}

#
# Root account of the organization: mainly used for consolidated billing reports
#  but it could also be used to manage the SCPs of the OUs and accounts.
#
resource "aws_organizations_account" "root" {
  name  = "project root"
  email = "aws.project+root@project.com"
}

#
# Security: this is a centralized account that we can use to grant
#  permissions over the other accounts.
#
resource "aws_organizations_account" "security" {
  name      = "security"
  email     = "aws.project+security@project.com"
  parent_id = aws_organizations_organizational_unit.security.id
}

#
# Shared: this account will be used to host shared resources that are consumed
#  or provide services to the other accounts.
#
resource "aws_organizations_account" "shared" {
  name      = "shared"
  email     = "aws.project+shared@project.com"
  parent_id = aws_organizations_organizational_unit.shared.id
}

#
# Project DevStg: services and resources related to development/stage are
#  placed and maintained here.
#
resource "aws_organizations_account" "project_devstg" {
  name      = "project_devstg"
  email     = "aws.project+project_devstg@project.com"
  parent_id = aws_organizations_organizational_unit.project_apps.id
}

#
# Project Prd: services and resources related to production are placed and
#  maintained here.
#
resource "aws_organizations_account" "project_prd" {
  name      = "project_prd"
  email     = "aws.project+project_prd@project.com"
  parent_id = aws_organizations_organizational_unit.project_apps.id
}

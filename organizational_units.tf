#
# Security: this is for centralized security access
#
resource "aws_organizations_organizational_unit" "security" {
    name      = "security"
    parent_id = aws_organizations_organization.main.roots.0.id
}

#
# Shared: this is for shared resources -- although another option could be to
# have a shared account per business unit (e.g. project, and others)
#
resource "aws_organizations_organizational_unit" "shared" {
    name      = "shared"
    parent_id = aws_organizations_organization.main.roots.0.id
}

#
# Project: this is for applications and services under Project Name.
#
resource "aws_organizations_organizational_unit" "project_apps" {
    name      = "project_apps"
    parent_id = aws_organizations_organization.main.roots.0.id
}

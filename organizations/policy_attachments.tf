#
# Security Organizational Unit Policies
#
resource "aws_organizations_policy_attachment" "security" {
  policy_id = aws_organizations_policy.default.id
  target_id = aws_organizations_organizational_unit.security.id
}

#
# Shared Organizational Unit Policies
#
resource "aws_organizations_policy_attachment" "shared" {
  policy_id = aws_organizations_policy.standard.id
  target_id = aws_organizations_organizational_unit.shared.id
}

#
# Project Organizational Unit Policies (should cover both devstg and prd)
#
resource "aws_organizations_policy_attachment" "project" {
  policy_id = aws_organizations_policy.standard.id
  target_id = aws_organizations_organizational_unit.project_apps.id
}

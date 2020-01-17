#
# Organization
#
resource "aws_organizations_organization" "main" {
    # Not needed at first, might be needed later: https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnableAWSServiceAccess.html
    aws_service_access_principals = []

    # Enable all feature set to enable SCPs
    feature_set = "ALL"

    # Enable Service Control Policies to enable custom SCPs
    enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}

data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "infra" {
  name      = var.infra_ou_name
  parent_id = data.aws_organizations_organization.org.roots[0].id
}
resource "aws_organizations_organizational_unit" "dev" {
  name      = var.dev_ou_name
  parent_id = aws_organizations_organizational_unit.infra.id
}
resource "aws_organizations_organizational_unit" "prod" {
  name      = var.prod_ou_name
  parent_id = aws_organizations_organizational_unit.infra.id
}

# Sample SCP: deny root user in all child OUs
resource "aws_organizations_policy" "deny_root" {
  name        = "DenyRootUser"
  description = "Prevent root user actions"
  type        = "SERVICE_CONTROL_POLICY"
  content     = jsonencode({
    Version   = "2012-10-17",
    Statement = [{ Effect = "Deny", Action = "*", Resource = "*", Condition = {
      StringLike = { "aws:PrincipalArn" = ["arn:aws:iam::*:root"] }
    }}]
  })
}

# Attach SCP to OUs
resource "aws_organizations_policy_attachment" "denyroot_dev" {
  policy_id = aws_organizations_policy.deny_root.id
  target_id = aws_organizations_organizational_unit.dev.id
}
resource "aws_organizations_policy_attachment" "denyroot_prod" {
  policy_id = aws_organizations_policy.deny_root.id
  target_id = aws_organizations_organizational_unit.prod.id
}

## OIDC PROVIDER
resource "aws_iam_openid_connect_provider" "oidc" {
  count           = var.create ? 1 : 0
  url             = var.oidc_url
  client_id_list  = var.oidc_client_id_list
  thumbprint_list = var.oidc_thumbprint_list
}

## OIDC ROLE
resource "aws_iam_role" "oidc" {
  count = var.create ? 1 : 0
  name  = "github-oidc-terraform-${var.account_handle}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:${var.oidc_org}/${var.oidc_repo}:${var.oidc_branch}"
                },
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
EOF

  tags = merge(
    {
      "Name"        = aws_iam_role.oidc.name
      "Region"      = var.region
      "Provisioner" = var.provisioner
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "oidc" {
  count      = var.create ? 1 : 0
  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.oidc.arn
}

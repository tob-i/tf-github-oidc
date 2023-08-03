## TERRAFORM POLICY
data "aws_iam_policy_document" "terraform_execution" {
  statement {
    sid = "AllowEverythingButAdministrativeAccountTasks"

    not_actions = [
      "account:*",
      "cur:*",
      "invoicing:*",
      "tax:*",
      "purchase-orders:*",
      "payments:*",
      "sustainability:*",
      "consolidatedbilling:*",
      "pricing:*",
      "freetier:*",
      "billing:*",
      "support:*",
      "billingconductor:*",
      "budgets:*",
      "servicequotas:*"
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowPutAlternateContactOnAccount"

    actions = [
      "account:*AlternateContact"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_execution" {
  count  = var.create ? 1 : 0
  name   = "terraform-execution-policy"
  policy = data.aws_iam_policy_document.terraform_execution.json
}

variable "create" {
  description = "Bool value for creating resources"
  type        = string
  default     = false
}

variable "account_id" {
  description = "Value for account id"
  type        = string
}

variable "account_handle" {
  description = "Value for account handle e.g. mgmt"
  type        = string
}

variable "oidc_url" {
  description = "Value for OIDC url"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "oicd_client_list" {
  description = "Value for Client list"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "oidc_thumbprint_list" {
  description = "Value for Thumbprint List"
  type        = list(string)
  default     = ["1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

variable "github_oidc_org" {
  description = "GitHub Org scope for assume OIDC role"
  type        = string
}

variable "github_oidc_repo" {
  description = "GitHub Repo scope for assume OIDC role"
  type        = string
}

variable "github_oidc_branch" {
  description = "GitHub Branch scope for assume OIDC role"
}

variable "tags" {
  description = "List with default tags if provided"
  type        = optional(map(string))
}

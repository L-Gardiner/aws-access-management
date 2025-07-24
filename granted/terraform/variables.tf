variable "aws_account_id" {
  description = "AWS account ID (12-digit)"
  type        = string
  sensitive   = true
}

variable "granted_iam_user" {
  description = "IAM user who can assume this role"
  type        = string
}
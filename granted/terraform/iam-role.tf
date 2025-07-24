resource "aws_iam_role" "granted_admin" {
  name = "granted-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${var.aws_account_id}:user/${var.granted_iam_user}"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  max_session_duration = 43200 # 12 hours
}

resource "aws_iam_role_policy_attachment" "granted_admin_policy" {
  role       = aws_iam_role.granted_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

// Break-Glass USER - Ask Allegiant before if they already have one in place! 

resource "aws_iam_user" "bgu" {
  name = "Allegiant-BreakglassUser"
}

resource "aws_iam_user_policy_attachment" "Admin-policy-attach" {
  user       = aws_iam_user.bgu.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "BreakGlassAssumeRolePolicy" {
  name        = "BreakGlassAssumeRolePolicy"
  description = "BreakGlassAssumeRolePolicy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect   = "Allow"
        Resource = "arn:aws:iam::*:role/BreakGlassRole"
      },
    ]
  })
}
resource "aws_iam_user_policy_attachment" "assumerole-policy-attach" {
  user       = aws_iam_user.bgu.name
  policy_arn = aws_iam_policy.BreakGlassAssumeRolePolicy.arn
}
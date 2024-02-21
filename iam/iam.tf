resource "aws_iam_role" "mlflow-server-role" {
  name = "test-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment_ssm" {
  role = aws_iam_role.mlflow-server-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "s3_policy_tf_test" {
  name = "s3_policy_tf_test"
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${var.s3_arn}",
        "${var.s3_arn}/*"
      ]
    }
  ]

}
EOT
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment_s3" {
  role = aws_iam_role.mlflow-server-role.name
  policy_arn = aws_iam_policy.s3_policy_tf_test.arn
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment_rds" {
  role = aws_iam_role.mlflow-server-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}

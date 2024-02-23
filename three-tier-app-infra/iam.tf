resource "aws_iam_policy" "db_access_policy" {
  name        = "${local.prefix}-db-access-policy"
  description = "Allows access to ${var.db_engine} DB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "rds:*"
        ],
        Resource = [
          module.db.arn,
        ],
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "db_access_policy_attachment" {
  name       = "${local.prefix}-db-access-policy-attachment"
  policy_arn = aws_iam_policy.db_access_policy.arn
  roles      = [module.backend_ecs_service.tasks_iam_role_name, module.backend_ecs_service.task_exec_iam_role_name]
}

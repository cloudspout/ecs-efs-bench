resource "aws_iam_role" "influxdb_execution" {
  name               = "ecs-efs-bench-${terraform.workspace}-influxdb_execution"
  assume_role_policy = data.aws_iam_policy_document.ECS_trust.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "influxdb_execution-attach-AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.influxdb_execution.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

resource "aws_iam_role" "influxdb" {
  name               = "ecs-efs-bench-${terraform.workspace}-influxdb"
  assume_role_policy = data.aws_iam_policy_document.ECS_trust.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "influxdb_secrets_access" {
  version = "2012-10-17"

  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      aws_secretsmanager_secret.influxdb_admin-password.arn,
      aws_secretsmanager_secret.influxdb_read-password.arn,
      aws_secretsmanager_secret.influxdb_write-password.arn
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "influxdb_secrets_access" {
  name        = "ecs-efs-bench-${terraform.workspace}-influxdb_secrets_access"
  description = ""

  policy = data.aws_iam_policy_document.influxdb_secrets_access.json
}

resource "aws_iam_role_policy_attachment" "influxdb_execution-attach-influxdb_secrets_access" {
  role       = aws_iam_role.influxdb_execution.name
  policy_arn = aws_iam_policy.influxdb_secrets_access.arn
}

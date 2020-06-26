resource "aws_secretsmanager_secret" "grafana_admin-password" {
  name = "ecs-efs-bench/${terraform.workspace}/grafana/admin-password"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "grafana_admin-password" {
  secret_id     = aws_secretsmanager_secret.grafana_admin-password.id
  secret_string = random_password.grafana_admin-password.result
}

resource "random_password" "grafana_admin-password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "influxdb_admin-password" {
  name = "ecs-efs-bench/${terraform.workspace}/influxdb/admin-password"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "influxdb_admin-password" {
  secret_id     = aws_secretsmanager_secret.influxdb_admin-password.id
  secret_string = random_password.influxdb_admin-password.result
}

resource "random_password" "influxdb_admin-password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "influxdb_read-password" {
  name = "ecs-efs-bench/${terraform.workspace}/influxdb/read-password"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "influxdb_read-password" {
  secret_id     = aws_secretsmanager_secret.influxdb_read-password.id
  secret_string = random_password.influxdb_read-password.result
}

resource "random_password" "influxdb_read-password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "influxdb_write-password" {
  name = "ecs-efs-bench/${terraform.workspace}/influxdb/write-password"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "influxdb_write-password" {
  secret_id     = aws_secretsmanager_secret.influxdb_write-password.id
  secret_string = random_password.influxdb_write-password.result
}

resource "random_password" "influxdb_write-password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

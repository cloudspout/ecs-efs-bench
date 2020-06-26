module "fargate-influxdb-efs-candidate" {
  source  = "/Users/sebastian/development/cloudspout/fargate-influxdb-efs"

  name   = "efscandidate"
  tags   = local.common_tags

  aws_service_discovery_private_dns_namespace = aws_service_discovery_private_dns_namespace.ecs-efs-bench


  aws_ecs_cluster = aws_ecs_cluster._
  cpu    = var.influxdb_candiate_cpu
  memory = var.influxdb_candidate_memory

  execution_role = aws_iam_role.influxdb_execution
  task_role      = aws_iam_role.influxdb

  auth_enabled = false
  admin_user                                 = "influxdb"
  aws_secretsmanager_secret-admin_password   = aws_secretsmanager_secret.influxdb_admin-password
  rw_user                                    = "rw"
  aws_secretsmanager_secret-rw_user_password = aws_secretsmanager_secret.influxdb_read-password
  ro_user                                    = "ro"
  aws_secretsmanager_secret-ro_user_password = aws_secretsmanager_secret.influxdb_write-password

  aws_vpc            = aws_vpc._
  aws_subnets        = aws_subnet.public.*
  aws_security_group = aws_security_group.influxdb_access
}

module "fargate-influxdb-ecs-candidate" {
  source  = "/Users/sebastian/development/cloudspout/fargate-influxdb-efs"

  name   = "ecscandidate"
  use_efs = false
  tags   = local.common_tags

  aws_service_discovery_private_dns_namespace = aws_service_discovery_private_dns_namespace.ecs-efs-bench


  aws_ecs_cluster = aws_ecs_cluster._
  cpu    = var.influxdb_candiate_cpu
  memory = var.influxdb_candidate_memory

  execution_role = aws_iam_role.influxdb_execution
  task_role      = aws_iam_role.influxdb

  auth_enabled = false
  admin_user                                 = "influxdb"
  aws_secretsmanager_secret-admin_password   = aws_secretsmanager_secret.influxdb_admin-password
  rw_user                                    = "rw"
  aws_secretsmanager_secret-rw_user_password = aws_secretsmanager_secret.influxdb_read-password
  ro_user                                    = "ro"
  aws_secretsmanager_secret-ro_user_password = aws_secretsmanager_secret.influxdb_write-password

  aws_vpc            = aws_vpc._
  aws_subnets        = aws_subnet.public.*
  aws_security_group = aws_security_group.influxdb_access
}


resource "aws_service_discovery_private_dns_namespace" "ecs-efs-bench" {
  name = "ecs-efs-bench.local"
  vpc  = aws_vpc._.id
}

output "ec2_ip" {
    value = aws_instance.bench.public_ip
}

output "ec2_ssh" {
    value = "ssh ec2-user@${aws_instance.bench.public_ip}"
}

output "influxdb-efs_candidate" {
    value = "${module.fargate-influxdb-efs-candidate.registry.name}.${aws_service_discovery_private_dns_namespace.ecs-efs-bench.name}"
}

output "influxdb-ecs_candidate" {
    value = "${module.fargate-influxdb-ecs-candidate.registry.name}.${aws_service_discovery_private_dns_namespace.ecs-efs-bench.name}"
}

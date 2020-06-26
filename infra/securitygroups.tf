

resource "aws_security_group" "ec2_access" {
  name        = "ecs-efs-bench-${terraform.workspace}-ec2_access"
  description = "Allow access to the Influxdb"
  vpc_id      = aws_vpc._.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "influxdb_access" {
  name        = "ecs-efs-bench-${terraform.workspace}-influxdb_access"
  description = "Allow access to the Influxdb"
  vpc_id      = aws_vpc._.id

  ingress {
    from_port = 8086
    to_port   = 8086
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ec2_access.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "ecs-efs-bench-${terraform.workspace}-influxdb_access"
  })
}


resource "aws_security_group" "efs_grafana_access" {
  name        = "ecs-efs-bench-${terraform.workspace}-EFS-grafana-access"
  description = "Allow access to the Grafana EFS"
  vpc_id      = aws_vpc._.id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    security_groups = [
     // aws_security_group.grafana_access.id,
    ]
  }

  tags = merge(local.common_tags, {
    Name = "Gefjun-${terraform.workspace}-EFS-grafana-access"
  })
}

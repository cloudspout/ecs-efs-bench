data "aws_ami" "latest_ubuntu" {
most_recent = true
owners = ["amazon"] # AWS

  filter {
      name   = "name"
      values = ["amzn2-ami-hvm-*x86_64*"]
  }
}

resource "aws_instance" "bench" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"

user_data = <<EOF
#!/bin/bash
yum update -y 
yum install -y golang git wget curl
EOF
//go get github.com/influxdata/inch/cmd/inch
// ./go/bin/inch -m 10 -b 100 -c 1 -f 1 -p 100 -t "10,10" -user influxdb -password "RvFfrTbPa6fE"   -host http://ecs-efs-candidate-influxdb.ecs-efs-bench.local:8086
//  AWS_PROFILE=cloudspout terraform destroy -target aws_instance.bench -target aws_ecs_cluster._
vpc_security_group_ids = [
    aws_security_group.ec2_access.id
]
subnet_id =aws_subnet.public[0].id
associate_public_ip_address = true

key_name = aws_key_pair._.key_name

  tags = local.common_tags
}

resource "aws_key_pair" "_" {
  tags = local.common_tags

  key_name   = "ecs-efs-bench"
  public_key = file("~/.ssh/id_rsa.pub")
}
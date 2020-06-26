data "aws_availability_zones" "available" {}

resource "aws_vpc" "_" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(local.common_tags, {
    Name = "ecs-efs-bench-${terraform.workspace}-VPC"
  })
}

resource "aws_internet_gateway" "_" {
  vpc_id = aws_vpc._.id
  tags = merge(local.common_tags, {
    Name = "ecs-efs-bench-${terraform.workspace}-IGW"
  })
}

resource "aws_subnet" "public" {
  #count = length(data.aws_availability_zones.available.names)
  count = 2

  vpc_id                  = aws_vpc._.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {
    Name       = "ecs-efs-bench-${terraform.workspace}-Public-${data.aws_availability_zones.available.names[count.index]}"
    Visibility = "public"
  })
}

resource "aws_route_table" "public" {
  #count = length(data.aws_availability_zones.available.names)
  count = 2

  vpc_id = aws_vpc._.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway._.id
  }

  tags = merge(local.common_tags, {
    Name = "ecs-efs-bench-${terraform.workspace}-Public-${data.aws_availability_zones.available.names[count.index]}"
  })
}

resource "aws_route_table_association" "public" {
  #count = length(data.aws_availability_zones.available.names)
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

#resource "aws_eip" "nat" {
#  count = length(data.aws_availability_zones.available.names)
#  vpc      = true
#  
#  tags = merge(local.common_tags, {
#    Name = "Gefjun-${terraform.workspace}-NAT-${data.aws_availability_zones.available.names[count.index]}"
#  })
#}
#
#resource "aws_nat_gateway" "_" {
#  count = length(data.aws_availability_zones.available.names)
#  allocation_id = aws_eip.nat[count.index].id
#  subnet_id = aws_subnet.public[count.index].id
#
#  tags = merge(local.common_tags, {
#    Name = "Gefjun-${terraform.workspace}-${data.aws_availability_zones.available.names[count.index]}"
#  })
#
#  depends_on = [aws_internet_gateway._]
#}
#
#resource "aws_subnet" "private" {
#  count = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc._.id
#  cidr_block = "10.0.${254-count.index}.0/24"
#  availability_zone = data.aws_availability_zones.available.names[count.index]
#  map_public_ip_on_launch = false
#  tags = merge(local.common_tags, {
#    Name = "Gefjun-${terraform.workspace}-Private-${data.aws_availability_zones.available.names[count.index]}"
#    Visibility = "private"
#  })
#}
#
#resource "aws_route_table" "private" {
#  count = length(data.aws_availability_zones.available.names)
#    vpc_id = aws_vpc._.id
#
#    route {
#        cidr_block = "0.0.0.0/0"
#        gateway_id = aws_nat_gateway._[count.index].id
#    }
#
#  tags = merge(local.common_tags, {
#    Name = "Gefjun-${terraform.workspace}-Private-${data.aws_availability_zones.available.names[count.index]}"
#  })
#}
#
#resource "aws_route_table_association" "private" {
#    count = length(data.aws_availability_zones.available.names)
#    subnet_id = aws_subnet.private[count.index].id
#    route_table_id = aws_route_table.private[count.index].id
#}

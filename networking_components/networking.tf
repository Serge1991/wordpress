### Create a VPC    

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name_tag} - vpc"
  }
}

### Create a IGW

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name_tag} - gw"
  }
}

### Create route table for public subnets

resource "aws_route_table" "wordpress_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "${var.name_tag} - rt"
  }
}
### Create a NAT GW

resource "aws_nat_gateway" "NAT" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.public_1.id

  tags = {
    Name = "${var.name_tag} - NAT"
  }
}
### Create route table for private subnets

resource "aws_route_table" "wordpress_rt_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "${var.name_tag} - rt-private"
  }
}

### Create public subnets

resource "aws_subnet" "public_1" {
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "${var.name_tag}- public_1"
  }
}

resource "aws_subnet" "public_2" {
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "${var.name_tag} - public_2"
  }
}
resource "aws_subnet" "public_3" {
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "${var.name_tag} - public_3"
  }
}

### Create private subnets

resource "aws_subnet" "private_1" {
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "${var.name_tag} - private_1"
  }
}
resource "aws_subnet" "private_2" {
  availability_zone = var.availability_zone_2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "${var.name_tag} - private_2"
  }
}
resource "aws_subnet" "private_3" {
  availability_zone = var.availability_zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "${var.name_tag} - private_3"
  }
}

###Route table association public subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.wordpress_rt.id
}
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.wordpress_rt.id
}
resource "aws_route_table_association" "public_3" {
  subnet_id      = aws_subnet.public_3.id
  route_table_id = aws_route_table.wordpress_rt.id
}

###Route table association private subnets

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.wordpress_rt_private.id
}
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.wordpress_rt_private.id
}
resource "aws_route_table_association" "private_3" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.wordpress_rt_private.id
}

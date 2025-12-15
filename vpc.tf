resource "aws_vpc" "vpc_test_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC-test-terraform-virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_test_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "public-subnet-test-terraform-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_test_virginia.id
  cidr_block = var.subnets[1]
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "private-subnet-test-terrform-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "ig-test-terraform" {
  vpc_id = aws_vpc.vpc_test_virginia.id

  tags = {
    Name = "ig-vpc-test-virgnia-${local.sufix}"
  }
}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc_test_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-test-terraform.id
  }

  tags = {
    Name = "public-rt-test-${local.sufix}"
  }
}

resource "aws_route_table_association" "asso-rt-public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_security_group" "sg-ec2-public-test" {
  name        = "ec2-public-sg-test"
  description = "sg para la ec2 publica permitiendo todo el trafico"
  vpc_id      = aws_vpc.vpc_test_virginia.id

   dynamic "ingress" {
     for_each = var.ingress_port_list
     content {
       from_port = ingress.value
       to_port = ingress.value
       protocol = "tcp"
       cidr_blocks = [ var.sg_ingress_cidr ]
     }
   }

  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-ec2-public-test-${local.sufix}"
  }

}


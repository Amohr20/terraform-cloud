virginia_cidr = "10.0.0.0/16"
# public_subnet = "10.0.1.0/24"
# private_subnet = "10.0.2.0/24"
subnets = ["10.0.1.0/24", "10.0.2.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "Angel"
  "cloud"       = "aws"
  "IAC"         = "terraform"
  "IAC_version" = "1.14.0"
  "project" = "amohr"
  "region" = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
}

enable_monitoring = 0

ingress_port_list = [ 22, 80]

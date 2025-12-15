variable "instancias" {
  description = "nombre de las instancias"
  #type = set(string)--> otra forma de hacerlo 1
  type = list(string)
  default = [ "apache" ]
}

resource "aws_instance" "public_ec2" {
  #for_each = var.instancias --> otra forma de hacerlo 1.1
  for_each = toset(var.instancias)
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.sg-ec2-public-test.id ]
  key_name = data.aws_key_pair.key.key_name
  user_data = file("${path.module}/scripts/userdata.sh")
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring == 1 ? 1:0
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.sg-ec2-public-test.id ]
  key_name = data.aws_key_pair.key.key_name

  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }
}
variable "virginia_cidr" {
  description = "cidr virginia"
  type        = string
  sensitive   = false
}

# variable "public_subnet" {
#   description = "CIDR public subnet"
#   type = string
# }

# variable "private_subnet" {
#   description = "CIDR private subnet"
#   type = string
# }

variable "subnets" {
  description = "lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "cidr ingress"
  type = string
}

variable "ec2_specs" {
  description = "parametros de la ec2"
  type = map(string)
}

variable "enable_monitoring" {
  description = "habilita el despliegue de un servidor de monitoreo"
  type = number
}

variable "ingress_port_list" {
  description = "lista de puerto ingress"
  type = list(number)
}
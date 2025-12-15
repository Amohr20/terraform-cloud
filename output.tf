output "ec2_public_ip" {
  description = "ip publica de la ec2"
  value       = [for ec2 in aws_instance.public_ec2 : ec2.public_ip]
}
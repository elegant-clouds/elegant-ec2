output "node01_subnet_id" {
  value = aws_subnet.node01_subnet.id
}

output "node01_sg_id" {
  value = aws_security_group.node01_sg.id
}
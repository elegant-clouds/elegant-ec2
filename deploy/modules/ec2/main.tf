resource "aws_key_pair" "terralogin" {
  key_name   = var.ssh_key_name
  public_key = var.pub_key
}

resource "aws_instance" "node01" {
  ami                         = var.ami_os
  instance_type               = var.ami_type
  key_name                    = aws_key_pair.terralogin.key_name
  subnet_id                   = var.node01_subnet_id
  vpc_security_group_ids      = [var.node01_sg_id]
  associate_public_ip_address = true
}
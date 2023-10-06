resource "aws_instance" "wordpress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_sg]
  key_name                    = var.key_name
  associate_public_ip_address = true
  #user_data                   = file("~/Desktop/terrafrom/wordpress_project/ec2/script.tpl")

  tags = {
    Name = "wordpress-ec2"
  }
}

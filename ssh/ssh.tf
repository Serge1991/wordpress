resource "aws_key_pair" "ssh312" {
  key_name   = var.key_name
  public_key = var.public_key
}

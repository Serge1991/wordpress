output "vpc_security_group_ids" {
  value = aws_security_group.wordpress_sg.id

}
output "wordpress_sg" {
  value = aws_security_group.wordpress_sg
}

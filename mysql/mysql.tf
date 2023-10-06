resource "aws_db_subnet_group" "subnet-gr" {
  name       = "subnet-group"
  subnet_ids = [var.subnet_id, var.subnet_id_2]
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true

  vpc_security_group_ids = [var.vpc_security_group_ids]

  db_subnet_group_name = aws_db_subnet_group.subnet-gr.name

  tags = {
    Name = "mysql"
  }
}

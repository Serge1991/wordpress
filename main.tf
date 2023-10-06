terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.18"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}

module "ssh_key" {
  source     = "./ssh"
  key_name   = "312.pem"
  public_key = file("~/.ssh/312.pem.pub")
}


module "network" {
  source              = "./networking_components"
  vpc_cidr            = "10.0.0.0/16"
  availability_zone   = "us-east-1a"
  availability_zone_2 = "us-east-1b"
  name_tag            = "wordpress"

}

module "sg" {
  source   = "./sg"
  name_tag = "wordpress"
  vpc_id   = module.network.vpc_id
}
module "rds_sg" {
  source          = "./rds-sg"
  vpc_id          = module.network.vpc_id
  security_groups = module.sg.vpc_security_group_ids
}

module "ec2" {
  source        = "./ec2"
  instance_type = "t2.micro"
  ami_id        = "ami-0bb4c991fa89d4b9b"
  key_name      = module.ssh_key.key_name
  vpc_sg        = module.sg.vpc_security_group_ids
  subnet_id     = module.network.public_1_id
  name_tag      = "wordpress"
}


module "mysql" {
  source                 = "./mysql"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "adminadmin"
  parameter_group_name   = "default.mysql5.7"
  subnet_id              = module.network.private_subnet_id_1
  subnet_id_2            = module.network.private_subnet_id_2
  vpc_security_group_ids = module.rds_sg.rgs_sg
}

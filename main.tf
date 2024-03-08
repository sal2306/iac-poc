provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block        = var.cidr_block
  cidr_block_subnet = "10.0.0.0/24"
}

module "security_group" {
  source     = "./modules/security_group"
  vpc_id     = module.vpc.vpc_id
  sg_name    = "web-sg"
}

module "iam_user" {
  source  = "./modules/iam"
  iam_user_name = "web_user"
}

module "lb" {
  source              = "./modules/load_balancer"
  subnet_id           = module.vpc.subnet_id
  security_group_id   = module.security_group.security_group_id
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "aws_route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.igw_id
}

module "autoscaling_group" {
  source             = "./modules/autoscaling_group"
  asg_name           = "webserver-asg"
  image_id           = "ami-12345678" #Replace with correct AMI id
  instance_type      = "t2.micro" #Replace with desired instance type
  subnet_id          = module.vpc.subnet_id
  security_group_id  = module.security_group.security_group_id
}

output "load_balancer_dns" {
  value = module.load_balancer.lb_dns
}

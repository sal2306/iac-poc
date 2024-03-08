resource "aws_lb" "web_lb" {
  name               = "zantac_web_lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]  # Reference the security group created in Security Group module
  subnets            = [var.subnet_id]          # Reference the subnet created in VPC module

}

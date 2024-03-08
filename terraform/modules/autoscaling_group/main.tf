resource "aws_autoscaling_group" "webserver_asg" {
  name                 = var.asg_name
  vpc_zone_identifier  = var.subnet_id
  launch_configuration = aws_launch_configuration.webserver_lg.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
}

resource "aws_launch_configuration" "webserver_lg" {
  name_prefix          = "webserver-lc-"
  image_id             = var.image_id
  instance_type        = var.instance_type
  security_groups      = [var.security_group_id] 
}
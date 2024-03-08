resource "aws_security_group" "web_sg" {
  name        = var.sg_name
  description = "Security group for web server"
  vpc_id      = var.vpc_id

  // Ingress rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
